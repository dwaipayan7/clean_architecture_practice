import 'dart:io';
import 'package:clean_architecture/cors/error/exception.dart';
import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/network/connection_checker.dart';
import 'package:clean_architecture/features/blogs/data/datasources/blog_local_data_source.dart';
import 'package:clean_architecture/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture/features/blogs/data/models/blog_model.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:clean_architecture/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(this.blogLocalDataSource, this.connectionChecker, {required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if(!await (connectionChecker.isConnected)){
        return Either.left(Failure("No internet connection"));
      }
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

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async{
   
    try{

      if(!await (connectionChecker.isConnected)){
          final blogs = blogLocalDataSource.loadBlogs();
          return Either.right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return Either.right(blogs);
      
    }on ServerException catch(e){
      throw Exception(e.toString());
    }
    
  }
}
