
import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/usecase/usecase.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:clean_architecture/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams>{
  final BlogRepository repository;

  GetAllBlogs({required this.repository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{

    return await repository.getAllBlogs();

  }

}