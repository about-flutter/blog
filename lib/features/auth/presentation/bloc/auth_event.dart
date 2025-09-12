part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  const AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {
  const AuthIsUserLoggedIn();
}

final class AuthLogout extends AuthEvent {
  const AuthLogout();
}
