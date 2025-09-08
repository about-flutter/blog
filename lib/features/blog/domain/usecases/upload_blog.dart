import 'dart:io';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';



class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository repository;
  UploadBlog(this.repository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) {
    return repository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File? image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
