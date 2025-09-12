import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:flutter/material.dart';

/// A service to handle errors consistently across the application
class ErrorHandler {
  /// Convert an exception to a failure for domain layer
  static Failure exceptionToFailure(dynamic exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is AuthException) {
      return AuthFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    } else {
      return ServerFailure(exception.toString());
    }
  }

  /// Display a error message to the user
  static void showError(BuildContext context, String message) {
    showSnackBar(context, message);
  }

  /// Log an error to the console (in production, this would use a proper logging service)
  static void logError(dynamic error, {StackTrace? stackTrace}) {
    // In a real application, this would log to a service like Firebase Crashlytics
    debugPrint('ERROR: $error');
    if (stackTrace != null) {
      debugPrint('STACK TRACE: $stackTrace');
    }
  }

  /// Handle a failure by showing a message and logging
  static void handleFailure(BuildContext context, Failure failure) {
    showError(context, failure.message);
    logError(failure.message);
  }
}
