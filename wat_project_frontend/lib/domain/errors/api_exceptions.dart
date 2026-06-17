class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String message = 'Unauthorized'}) : super(message, statusCode: 401);
}
