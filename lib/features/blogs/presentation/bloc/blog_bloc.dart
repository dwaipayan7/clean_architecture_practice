import 'dart:async';
import 'dart:io';
import 'package:clean_architecture/cors/usecase/usecase.dart';
import 'package:clean_architecture/features/blogs/domain/entities/blog.dart';
import 'package:clean_architecture/features/blogs/domain/usecase/get_all_blogs.dart';
import 'package:clean_architecture/features/blogs/domain/usecase/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onFetchAllBlogs);
  }

  FutureOr<void> _onBlogUpload(
      BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    result.fold(
        (l) => emit(BlogFailure(error: l.message)), (r) => emit(BlogUploadSuccess()));
  }

  FutureOr<void> _onFetchAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async{

    final res = await _getAllBlogs(NoParams());

    res.fold(
            (l) => emit(BlogFailure(error: l.message)),
            (r) => emit(BlogDisplaySuccess(blogs: r),),);

  }
}
