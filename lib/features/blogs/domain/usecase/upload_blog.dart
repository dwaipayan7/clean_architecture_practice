import 'dart:io';

import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/usecase/usecase.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:clean_architecture/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async{
   return await blogRepository.uploadBlog(
       image: params.image,
       title: params.title,
       content: params.content,
       posterId: params.posterId,
       topics: params.topics
   );
  }
}


class UploadBlogParams{
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String>topics;

  UploadBlogParams({required this.posterId, required this.title, required this.content, required this.image, required this.topics,});
}