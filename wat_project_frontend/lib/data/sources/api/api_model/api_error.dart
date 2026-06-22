import 'field_error.dart';

class ApiError {
  final String code;
  final String message;
  final List<FieldError> details;

  const ApiError({
    required this.code,
    required this.message,
    this.details = const [],
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    final errorJson = json['error'] as Map<String, dynamic>? ?? json;
    
    var detailsList = <FieldError>[];
    if (errorJson['details'] != null && errorJson['details'] is List) {
      detailsList = (errorJson['details'] as List)
          .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final type = errorJson['type'] as String?;
    final title = errorJson['title'] as String?;
    final detail = errorJson['detail'] as String?;

    final parsedCode = errorJson['code'] as String? ?? type ?? 'unknown_error';
    final parsedTitle = errorJson['message'] as String? ?? title ?? 'An unknown error occurred.';
    final finalMessage = detail != null && detail.isNotEmpty ? '$parsedTitle: $detail' : parsedTitle;

    return ApiError(
      code: parsedCode,
      message: finalMessage,
      details: detailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': {
        'code': code,
        'message': message,
        'details': details.map((e) => e.toJson()).toList(),
      }
    };
  }
}
