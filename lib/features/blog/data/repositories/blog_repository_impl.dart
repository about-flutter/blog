import 'dart:io';

import 'package:blog/core/error/error_handler.dart';
import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File? image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(NetworkFailure('No internet connection'));
      }

      // Create initial BlogModel (without imageUrl)
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      String imageUrl = '';

      if (image != null) {
        try {
          imageUrl = await blogRemoteDataSource.uploadBlogImage(
            image: image,
            blog: blogModel,
          );
          blogModel = blogModel.copyWith(imageUrl: imageUrl);
        } catch (e) {
          // If image upload fails, continue with empty imageUrl
          print('Image upload failed: ${e.toString()}');
        }
      }

      // Upload blog to Supabase
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        // Load from local cache if no connection
        final blogs = await blogLocalDataSource.loadBlogs();
        return Right(blogs);
      }

      // Load from remote if connected
      final blogs = await blogRemoteDataSource.getAllBlogs();

      // Save to local cache
      blogLocalDataSource.upLoadLocalBlogs(blogs: blogs);

      return Right(blogs);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
