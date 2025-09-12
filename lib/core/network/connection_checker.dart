import 'package:blog/core/error/exceptions.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  /// Check if the device has an internet connection
  Future<bool> get isConnected;

  /// Check if there's a connection and throw an exception if not
  Future<void> checkConnection();
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;

  @override
  Future<void> checkConnection() async {
    if (!await isConnected) {
      throw const NetworkException(
        'No internet connection. Please check your connection and try again.',
      );
    }
  }
}
