import 'package:blog/features/blog/presentation/view/blog_screen.dart';
import 'package:blog/features/blog/presentation/view/add_new_blog.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BlogModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const BlogScreen());
    r.child('/add', child: (context) => const AddNewBlog());
  }
}
