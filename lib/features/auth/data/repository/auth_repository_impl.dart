import 'package:clean_architecture/cors/common/entities/user.dart';
import 'package:clean_architecture/cors/error/exception.dart';
import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/network/connection_checker.dart';
import 'package:clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clean_architecture/features/auth/data/model/user_models.dart';
import 'package:clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase/supabase.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.connectionChecker, {required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return Either.left(
            Failure("User not logged in"),
          );
        }

        return Either.right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }

      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return Either.left(Failure("User not logged in"));
      }
      return Either.right(user);
    } on ServerException catch (e) {
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
      if (!await (connectionChecker.isConnected)) {
        return Either.left(Failure("No Internet Connection"));
      }
      final user = await fn();

      return Either.right(user);
    } on sb.AuthException catch (e) {
      return Either.left(Failure(e.message));
    } on ServerException catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }
}
