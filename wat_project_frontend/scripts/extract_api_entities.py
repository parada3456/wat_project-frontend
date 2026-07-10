#!/usr/bin/env python3
import os
import re
import sys
import argparse
import json
import csv
import io
from typing import List, Dict, Any

def extract_clean_entity(future_type: str) -> str:
    """Recursively unwraps wrappers like PaginationResponse, List, and Response to find the entity name."""
    future_type = future_type.strip()
    # Check for PaginationResponse<Inner> or List<Inner> or Response<Inner>
    wrapper_pattern = re.compile(r'^(?:PaginationResponse|List|Response)\s*<(.*)>$', re.IGNORECASE)
    match = wrapper_pattern.match(future_type)
    if match:
        return extract_clean_entity(match.group(1))
    return future_type

def parse_api_file(content: str) -> List[Dict[str, Any]]:
    """Parses a Dart file containing Retrofit annotations and returns a list of endpoint dictionaries."""
    results = []
    
    # Try to find the Service class name
    class_match = re.search(r'(?:abstract\s+)?class\s+(\w+)', content)
    class_name = class_match.group(1) if class_match else "UnknownService"
    
    # Match annotations like @GET('route'), @POST("route"), etc.
    verb_pattern = re.compile(r'@(GET|POST|PUT|DELETE|PATCH)\s*\(\s*[\'"]([^\'"]+)[\'"]\s*\)')
    
    for match in verb_pattern.finditer(content):
        http_method = match.group(1)
        route_path = match.group(2)
        
        # Start searching for the method signature after the annotation
        search_start = match.end()
        
        # Limit the search range to not cross into the next verb annotation
        next_verb = verb_pattern.search(content, search_start)
        limit = next_verb.start() if next_verb else len(content)
        
        # Search for 'Future'
        future_match = re.search(r'\bFuture\s*<', content[search_start:limit])
        if not future_match:
            continue
            
        bracket_start = search_start + future_match.end() - 1
        
        # Find matching '>' using bracket depth count
        depth = 0
        future_type = None
        method_name = None
        
        for idx in range(bracket_start, limit):
            char = content[idx]
            if char == '<':
                depth += 1
            elif char == '>':
                depth -= 1
                if depth == 0:
                    future_type = content[bracket_start+1 : idx].strip()
                    # Now search for method name after the matching '>'
                    after_future = content[idx+1 : limit]
                    
                    # Clean up comments to ensure clean matching
                    clean_after = re.sub(r'//.*', '', after_future)
                    clean_after = re.sub(r'/\*.*?\*/', '', clean_after, flags=re.DOTALL)
                    
                    method_match = re.search(r'\b(\w+)\s*\(', clean_after)
                    if method_match:
                        method_name = method_match.group(1)
                    break
                    
        if future_type and method_name:
            entity = extract_clean_entity(future_type)
            results.append({
                "service": class_name,
                "method": method_name,
                "http_method": http_method,
                "route": route_path,
                "return_type": f"Future<{future_type}>",
                "entity": entity
            })
            
    return results

def format_markdown_table(routes: List[Dict[str, Any]]) -> str:
    if not routes:
        return "No API routes found."
    
    headers = ["Service", "Method", "HTTP Method", "Route", "Return Type", "Entity"]
    col_widths = [len(h) for h in headers]
    
    for r in routes:
        col_widths[0] = max(col_widths[0], len(r["service"]))
        col_widths[1] = max(col_widths[1], len(r["method"]))
        col_widths[2] = max(col_widths[2], len(r["http_method"]))
        col_widths[3] = max(col_widths[3], len(r["route"]))
        col_widths[4] = max(col_widths[4], len(r["return_type"]))
        col_widths[5] = max(col_widths[5], len(r["entity"]))
        
    lines = []
    # Header
    header_line = "| " + " | ".join(h.ljust(col_widths[i]) for i, h in enumerate(headers)) + " |"
    lines.append(header_line)
    
    # Separator
    sep_line = "| " + " | ".join("-" * col_widths[i] for i in range(len(headers))) + " |"
    lines.append(sep_line)
    
    # Rows
    for r in routes:
        row = [r["service"], r["method"], r["http_method"], r["route"], r["return_type"], r["entity"]]
        row_line = "| " + " | ".join(val.ljust(col_widths[i]) for i, val in enumerate(row)) + " |"
        lines.append(row_line)
        
    return "\n".join(lines)

def format_csv(routes: List[Dict[str, Any]]) -> str:
    if not routes:
        return ""
    output = io.StringIO()
    writer = csv.DictWriter(output, fieldnames=["service", "method", "http_method", "route", "return_type", "entity"])
    writer.writeheader()
    for r in routes:
        writer.writerow(r)
    return output.getvalue()

def format_json(routes: List[Dict[str, Any]]) -> str:
    return json.dumps(routes, indent=2)

def main():
    parser = argparse.ArgumentParser(description="Extract API routes and entities from Flutter Retrofit client files.")
    parser.add_name = "extract_api_entities"
    parser.add_argument("--dir", default="lib/data/sources/api", help="Directory to scan (default: lib/data/sources/api)")
    parser.add_argument("--format", choices=["table", "json", "csv"], default="table", help="Output format (default: table)")
    parser.add_argument("--output", help="Output file path (optional)")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.dir):
        print(f"Error: Directory '{args.dir}' does not exist.", file=sys.stderr)
        sys.exit(1)
        
    all_routes = []
    
    # Scan the directory recursively
    for root, _, files in os.walk(args.dir):
        for file in files:
            # We want to match *_api_client.dart and skip any *.g.dart files
            if file.endswith("_api_client.dart") and not file.endswith(".g.dart"):
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, "r", encoding="utf-8") as f:
                        content = f.read()
                    all_routes.extend(parse_api_file(content))
                except Exception as e:
                    print(f"Warning: Failed to parse {file_path}: {e}", file=sys.stderr)
                    
    # Format the output
    if args.format == "table":
        output_content = format_markdown_table(all_routes)
    elif args.format == "json":
        output_content = format_json(all_routes)
    elif args.format == "csv":
        output_content = format_csv(all_routes)
    else:
        output_content = ""
        
    # Write to file or stdout
    if args.output:
        try:
            with open(args.output, "w", encoding="utf-8") as f:
                f.write(output_content)
            print(f"Successfully wrote {len(all_routes)} API routes to {args.output}")
        except Exception as e:
            print(f"Error: Failed to write output to {args.output}: {e}", file=sys.stderr)
            sys.exit(1)
    else:
        print(output_content)

if __name__ == "__main__":
    main()
