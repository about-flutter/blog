import 'package:blog/app_module.dart';
import 'package:blog/core/constants/route_constants.dart';
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
    // Dependencies are injected in AppModule
  }

  @override
  void routes(RouteManager r) {
    r.child(
      RouteConstants.authRoot,
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const LoginScreen(),
      ),
    );

    r.child(
      RouteConstants.signUp,
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const SignUpScreen(),
      ),
    );
  }
}
