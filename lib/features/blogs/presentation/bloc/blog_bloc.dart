import 'dart:async';
import 'dart:io';
import 'package:clean_architecture/features/blogs/domain/usecase/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }

  FutureOr<void> _onBlogUpload(
      BlogUpload event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    
    result.fold(
            (l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogSuccess())
    );
    
  }
}
