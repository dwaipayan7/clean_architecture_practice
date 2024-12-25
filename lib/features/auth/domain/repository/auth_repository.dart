import 'package:clean_architecture/cors/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../cors/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
