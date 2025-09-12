import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/constants/route_constants.dart';
import 'package:blog/core/navigation/auth_guard.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/auth_module.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_logout.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/blog_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // External Dependencies
    i.addInstance<SupabaseClient>(Supabase.instance.client);
    i.addInstance<InternetConnection>(InternetConnection());

    // Core Components
    i.add<ConnectionChecker>(ConnectionCheckerImpl.new);

    // Auth Feature
    // - Datasource
    i.add<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);
    // - Repository
    i.add<AuthRepository>(AuthRepositoryImpl.new);
    // - UseCases
    i.add<UserSignUp>(UserSignUp.new);
    i.add<UserLogin>(UserLogin.new);
    i.add<CurrentUser>(CurrentUser.new);
    i.add<UserLogout>(UserLogout.new);
    // - Bloc
    i.addSingleton<AuthBloc>(AuthBloc.new);

    // Shared Application State
    i.addSingleton<AppUserCubit>(AppUserCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(RouteConstants.authModule, module: AuthModule());
    r.module(
      RouteConstants.blogModule,
      module: BlogModule(),
      guards: [AuthGuard()],
    );
    // Default redirect to auth route
    r.redirect('/', to: RouteConstants.authModule);
  }
}
