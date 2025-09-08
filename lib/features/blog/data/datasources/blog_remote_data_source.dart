import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response = await supabaseClient
          .from('blogs')
          .insert(blog.toMap())
          .select()
          .single();

      return BlogModel.fromMap(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage ({
    required File image,
    required BlogModel blog,
  }) async {
    try {
     await supabaseClient.storage.from('blog_images').upload(blog.id, image);
     return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
