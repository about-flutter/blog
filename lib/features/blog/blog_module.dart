import 'package:blog/app_module.dart';
import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/view/blog_screen.dart';
import 'package:blog/features/blog/presentation/view/add_new_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BlogModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.add<BlogRemoteDataSource>(BlogRemoteDataSourceImpl.new);
    i.add<BlogRepository>(BlogRepositoryImpl.new);

    i.add<UploadBlog>(UploadBlog.new);

    i.addSingleton<BlogBloc>(() => BlogBloc(i.get<UploadBlog>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<BlogBloc>(),
        child: const BlogScreen(),
      ),
    );
    r.child(
      '/add',
      child: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: Modular.get<BlogBloc>()),
          BlocProvider.value(value: Modular.get<AppUserCubit>()),
        ],
        child: const AddNewBlog(),
      ),
    );
  }
}
