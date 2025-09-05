import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/view/login_screen.dart';
import 'package:blog/features/auth/presentation/view/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // SupabaseClient
    i.addInstance<SupabaseClient>(Supabase.instance.client);

    // DataSource
    i.add<AuthRemoteDataSource>(AuthRemoteDatasourceImpl.new);

    // Repository
    i.add<AuthRepository>(AuthRepositoryImpl.new);

    // UseCase
    i.add<UserSignUp>(UserSignUp.new);

    // Bloc (cần UserSignUp)
    i.addSingleton<AuthBloc>(() => AuthBloc(userSignUp: i.get<UserSignUp>()));
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
