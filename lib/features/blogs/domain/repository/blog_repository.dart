import 'dart:io';

import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository{

  Future<Either<Failure, Blog>> uploadBlog({
   required File image,
   required String title,
   required String content,
   required String posterId,
   required List<String> topics,
});

}