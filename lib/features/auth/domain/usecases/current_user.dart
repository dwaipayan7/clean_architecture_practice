import 'package:clean_architecture/cors/error/failure.dart';
import 'package:clean_architecture/cors/usecase/usecase.dart';
import 'package:clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../cors/common/entities/user.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async{

    return await authRepository.currentUser();

  }
}


