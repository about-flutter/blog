import 'dart:io';

import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlog getAllBlog})
    : _uploadBlog = uploadBlog,
      _getAllBlog = getAllBlog,
      super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAll>(_onFetchAllBlog);
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _uploadBlog(
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
      (blog) => emit(BlogUpLoadSuccess()),
    );
  }

  Future<void> _onFetchAllBlog(
    BlogFetchAll event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());

    final res = await _getAllBlog(NoParams());
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogSuccess(blogs)),
    );
  }
}
