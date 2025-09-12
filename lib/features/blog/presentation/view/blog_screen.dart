import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/navigation/navigation_service.dart';
import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    Modular.get<BlogBloc>().add(BlogFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () => NavigationService.navigateToAddBlog(),
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person_circle),
            onPressed: () => NavigationService.navigateToProfile(),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        bloc: Modular.get<BlogBloc>(),
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: Loader());
          } else if (state is BlogFailure) {
            return Center(child: Text(state.message));
          } else if (state is BlogSuccess) {
            final blogs = state.blog;

            if (blogs.isEmpty) {
              return const Center(
                child: Text('No blogs found. Create your first blog!'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: blogs.length,

              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppPalette.gradient2
                      : (index % 3 == 1
                            ? AppPalette.gradient1
                            : AppPalette.gradient3),
                  onTap: () {
                    // Sử dụng Modular để điều hướng đến màn hình chi tiết
                    Modular.to.pushNamed('/blog/detail', arguments: blog);
                  },
                );
              },
            );
          }

          return const Center(
            child: Text('Pull to refresh or add a new blog!'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.get<BlogBloc>().add(BlogFetchAll());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
