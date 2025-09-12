/// Base exception class for the app
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Exception for server-related errors
class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred'])
    : super(message);
}

/// Exception for network connectivity issues
class NetworkException extends AppException {
  const NetworkException([String message = 'Network connection error'])
    : super(message);
}

/// Exception for authentication related errors
class AuthException extends AppException {
  const AuthException([String message = 'Authentication error'])
    : super(message);
}

/// Exception for cache-related errors
class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred'])
    : super(message);
}

/// Exception for validation errors
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation error'])
    : super(message);
}
