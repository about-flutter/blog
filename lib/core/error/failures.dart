/// Base failure class for domain layer errors
abstract class Failure {
  final String message;
  const Failure([this.message = 'An unexpected error occurred']);

  @override
  String toString() => message;
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
    : super(message);
}

/// Failure for network connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network connection error'])
    : super(message);
}

/// Failure for authentication related errors
class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication error']) : super(message);
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
    : super(message);
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation error'])
    : super(message);
}
