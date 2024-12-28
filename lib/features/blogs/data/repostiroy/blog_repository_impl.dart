import 'dart:io';

import 'package:clean_architecture/cors/error/exception.dart';
import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture/features/blogs/data/models/blog_model.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:clean_architecture/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

     final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

     blogModel.copyWith(
       imageUrl: imageUrl
     );

    final uploaded = await blogRemoteDataSource.uploadBlog(blogModel);
    return Either.right(uploaded);

    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
