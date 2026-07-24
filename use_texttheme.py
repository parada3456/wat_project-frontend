import re
import os

# Precise mapping for all your requested font sizes
SIZE_TO_THEME = [
    (7, "labelSmall"),
    (8, "labelMedium"),
    (9, "labelLarge"),
    (10, "bodySmall"),
    (11, "bodyMedium"),
    (12, "bodyLarge"),
    (13, "titleSmall"),
    (14, "titleMedium"),
    (18, "titleLarge"),
    (20, "headlineMedium"),
    (22, "displayLarge"),
]


def get_theme_type(font_size):
    """Finds the closest matching text theme type based on font size."""
    closest_style = "bodyMedium"  # Default fallback
    min_diff = float("inf")

    for size, style_name in SIZE_TO_THEME:
        diff = abs(font_size - size)
        if diff < min_diff:
            min_diff = diff
            closest_style = style_name

    return closest_style


def convert_text_styles(file_content):
    # Matches GoogleFonts.anyFontName(...) and handles multiline formats cleanly
    pattern = r"GoogleFonts\.[a-zA-Z0-9_]+\((.*?)\)"

    def replace_match(match):
        inner_content = match.group(1)

        # 1. Extract font size
        size_match = re.search(r"fontSize:\s*(\d+)", inner_content)
        if not size_match:
            theme_type = "bodyMedium"
        else:
            font_size = int(size_match.group(1))
            theme_type = get_theme_type(font_size)

        # 2. Extract color
        color_match = re.search(r"color:\s*([^,\n]+)", inner_content)
        color_str = (
            f"color: {color_match.group(1)},"
            if color_match
            else "color: AppColors.primary,"
        )

        # 3. Construct the clean AppTheme call
        new_style = f"AppTheme.textTheme.{theme_type}.copyWith({color_str})"
        return new_style

    return re.sub(pattern, replace_match, file_content, flags=re.DOTALL)

def process_file(file_path):
    """Reads a file, converts the styles, and writes it back if changes were made."""
    print(f"Processing: {file_path}")

    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Apply the conversion function
    updated_content = convert_text_styles(content)

    # Only write back to the file if something actually changed
    if content != updated_content:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(updated_content)
        print(f"✅ Successfully updated: {file_path}")
    else:
        print(f"  No changes needed in: {file_path}")


# --- Test case with various sizes ---
# if __name__ == "__main__":
#     test_code = """
#     var style1 = GoogleFonts.pressStart2p(fontSize: 7, color: AppColors.primary);
#     var style2 = GoogleFonts.pressStart2p(fontSize: 11, color: Colors.blue);
#     var style3 = GoogleFonts.pressStart2p(fontSize: 22, color: AppColors.secondary);
#     """
# #     print(convert_google_fonts_to_theme(test_code))
if __name__ == "__main__":
    # Option A: Process a single file directly
    # process_file('lib/screens/home_screen.dart')

    # Option B: Target your entire lib directory recursively
    # Change this line at the very bottom of your Python script:
    target_directory = "/Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/presentation"

    for root, dirs, files in os.walk(target_directory):
        for file in files:
            if file.endswith(".dart"):
                full_path = os.path.join(root, file)
                process_file(full_path)