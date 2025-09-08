import 'dart:io';


import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart'; // 👈 chỉ cần ở đây

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload); // ✅ viết gọn lại
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics,
      ),
    );

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogSuccess(blog)), // 👈 nên truyền blog vào state
    );
  }
}
