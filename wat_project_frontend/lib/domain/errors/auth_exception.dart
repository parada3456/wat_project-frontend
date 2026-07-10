class SessionExpiredException implements Exception {
  final String message;
  SessionExpiredException({
    this.message = 'Session has expired. Please login again.',
  });
}

class ProactiveRefreshFailedException implements Exception {
  final String message;
  ProactiveRefreshFailedException({
    this.message = 'Failed to refresh token proactively.',
  });
}

class QueuedRefreshFailedException implements Exception {
  final String message;
  QueuedRefreshFailedException({
    this.message = 'Failed to refresh token for queued request.',
  });
}

class AuthRetryFailedException implements Exception {
  final String message;
  AuthRetryFailedException({
    this.message = 'Authentication retry failed after token refresh.',
  });
}

class StorageSessionExpiredException implements Exception {
  final String message;
  StorageSessionExpiredException({
    this.message = 'Stored session is invalid or expired.',
  });
}
