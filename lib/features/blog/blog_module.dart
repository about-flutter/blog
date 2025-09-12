import 'package:blog/app_module.dart';
import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/constants/route_constants.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/view/profile_screen.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/view/blog_screen.dart';
import 'package:blog/features/blog/presentation/view/blog_detail_screen.dart';
import 'package:blog/features/blog/presentation/view/add_new_blog_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class BlogModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    // Local Storage
    i.addSingleton<Box>(() => Hive.box('blogBox'));

    // Blog Feature
    // - Datasources
    i.add<BlogRemoteDataSource>(BlogRemoteDataSourceImpl.new);
    i.add<BlogLocalDataSource>(BlogLocalDataSourceImpl.new);
    // - Repository
    i.add<BlogRepository>(BlogRepositoryImpl.new);
    // - UseCases
    i.add<UploadBlog>(UploadBlog.new);
    i.add<GetAllBlog>(GetAllBlog.new);
    // - Bloc
    i.addSingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: i.get<UploadBlog>(),
        getAllBlog: i.get<GetAllBlog>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      RouteConstants.blogRoot,
      child: (context) => BlocProvider.value(
        value: Modular.get<BlogBloc>(),
        child: const BlogScreen(),
      ),
    );
    r.child(
      RouteConstants.addBlog,
      child: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: Modular.get<BlogBloc>()),
          BlocProvider.value(value: Modular.get<AppUserCubit>()),
        ],
        child: const AddNewBlogScreen(),
      ),
    );

    r.child(
      RouteConstants.blogDetail,
      child: (context) => BlogDetailScreen(blog: r.args.data),
    );

    r.child(
      RouteConstants.profile,
      child: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: Modular.get<AuthBloc>()),
          BlocProvider.value(value: Modular.get<AppUserCubit>()),
        ],
        child: const ProfileScreen(),
      ),
    );
  }
}
