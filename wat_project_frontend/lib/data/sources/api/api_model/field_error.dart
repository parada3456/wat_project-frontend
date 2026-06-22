class FieldError {
  final String field;
  final String reason;

  const FieldError({
    required this.field,
    required this.reason,
  });

  factory FieldError.fromJson(Map<String, dynamic> json) {
    return FieldError(
      field: json['field'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'reason': reason,
    };
  }
}
