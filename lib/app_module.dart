import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/common/widgets/router_outlet.dart';
import 'package:blog/features/auth/auth_module.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/blog_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {
    // SupabaseClient
    i.addInstance<SupabaseClient>(Supabase.instance.client);

    // DataSource
    i.add<AuthRemoteDataSource>(AuthRemoteDatasourceImpl.new);

    // Repository
    i.add<AuthRepository>(AuthRepositoryImpl.new);

    // UseCases
    i.add<UserSignUp>(UserSignUp.new);
    i.add<UserLogin>(UserLogin.new);
    i.add<CurrentUser>(CurrentUser.new);
    i.add<AppUserCubit>(AppUserCubit.new);

    i.addSingleton<AuthBloc>(
      () => AuthBloc(
        userSignUp: i.get<UserSignUp>(),
        userLogin: i.get<UserLogin>(),
        currentUser: i.get<CurrentUser>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const EmptyRouterOutlet(),
      guards: [AuthGuard()],
    );
    r.module('/auth', module: AuthModule());
    r.module('/blog', module: BlogModule());
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/');

  @override
  Future<bool> canActivate(String path, ParallelRoute route) async {
    // Check if user is logged in using the AppUserCubit state
    final appUserCubit = Modular.get<AppUserCubit>();
    final state = appUserCubit.state;

    if (state is AppUserLoggedIn) {
      // User is logged in, redirect to blog
      Modular.to.navigate('/blog/');
      return false; // Don't continue with the original navigation
    }

    // User is not logged in, redirect to auth (using redirectTo in constructor)
    return false;
  }
}
