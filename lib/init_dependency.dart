import 'package:clean_architecture/cors/common/widgets/cubits/app_user_cubit.dart';
import 'package:clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clean_architecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture/features/auth/domain/usecases/user_login.dart';
import 'package:clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture/features/blogs/data/repostiroy/blog_repository_impl.dart';
import 'package:clean_architecture/features/blogs/domain/repository/blog_repository.dart';
import 'package:clean_architecture/features/blogs/domain/usecase/upload_blog.dart';
import 'package:clean_architecture/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cors/secrets/app_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseURL,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  _initAuth();

  _initBlog();

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  //Data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )

    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
      ),
    )
    //usecase
    ..registerFactory(
      () => UploadBlog(
        blogRepository: serviceLocator(),
      ),
    )
    //bloc
    ..registerLazySingleton(
      () => BlogBloc(
        serviceLocator(),
      ),
    );
}
