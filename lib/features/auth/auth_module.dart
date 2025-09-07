import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/view/login_screen.dart';
import 'package:blog/features/auth/presentation/view/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // Bindings are handled in AppModule (DI). This module only exposes
    // the auth routes when using Flutter Modular routing. If you prefer
    // Navigator-based routing (MaterialApp), you can keep DI in AppModule
    // and ignore these routes.
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const LoginScreen(),
      ),
      transition: TransitionType.fadeIn,
    );

    r.child(
      '/signup',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const SignUpScreen(),
      ),
      transition: TransitionType.rightToLeft,
    );
  }
}
