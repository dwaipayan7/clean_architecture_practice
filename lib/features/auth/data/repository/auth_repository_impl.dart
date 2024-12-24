import 'package:clean_architecture/cors/error/exception.dart';
import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase/supabase.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> currentUser() async{

    try{
      final user = await remoteDataSource.getCurrentUserData();

      if(user == null){
        return Either.left(Failure("User not logged in"));
      }
      return Either.right(user);

    }on ServerException catch(e){
      return Either.left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
    // final user =

    // return Either.right(user);
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );

    // return Either.right(user);
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return Either.right(user);
    }on sb.AuthException catch(e){
      return Either.left(Failure(e.message));
    } on ServerException catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }


}
