

import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlog implements UseCase<List<Blog>, NoParams> {
  final BlogRepository repository;

  GetAllBlog(this.repository);

  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await repository.getAllBlogs();
  }
}
