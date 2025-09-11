import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/network/connection_checker.dart';
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
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // SupabaseClient
    i.addInstance<SupabaseClient>(Supabase.instance.client);

    // Network
    i.addInstance<InternetConnection>(InternetConnection());
    i.add<ConnectionChecker>(ConnectionCheckerImpl.new);

    // Datasource
    i.add<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);

    // Repository
    i.add<AuthRepository>(AuthRepositoryImpl.new);

    // UseCases
    i.add<UserSignUp>(UserSignUp.new);
    i.add<UserLogin>(UserLogin.new);
    i.add<CurrentUser>(CurrentUser.new);

    // Bloc
    i.addSingleton<AuthBloc>(AuthBloc.new);

    // Cubit phụ thuộc vào AuthBloc
    i.addSingleton<AppUserCubit>(AppUserCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/blog', module: BlogModule());
    // Mặc định điều hướng đến trang auth
    r.redirect('/', to: '/auth/');
  }
}
