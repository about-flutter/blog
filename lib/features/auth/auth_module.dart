import 'package:blog/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:blog/features/auth/presentation/view/login_screen.dart';
import 'package:blog/features/auth/presentation/view/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(i) {
    // Tất cả dependencies đã được đăng ký trong AppModule
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const LoginScreen(),
      ),
    );

    r.child(
      '/signup',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const SignUpScreen(),
      ),
    );
  }
}
