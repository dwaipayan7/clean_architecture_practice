part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

class BlogLoading extends BlogState{}

class BlogFailure extends BlogState{
  final String error;

  BlogFailure({required this.error});
}

class BlogUploadSuccess extends BlogState{}

class BlogDisplaySuccess extends BlogState{
  final List<Blog> blogs;

  BlogDisplaySuccess({required this.blogs});
}
