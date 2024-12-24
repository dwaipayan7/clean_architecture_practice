import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/usecase/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository repository;

  UserLogin({required this.repository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
