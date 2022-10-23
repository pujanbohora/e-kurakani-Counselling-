// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:frontend/injectable.dart';

// ignore: unused_import
@injectable
class SignUpRegisterUser implements Usecase<User, User> {
  var signUpRepository = getIt<SignUpRepository>();

  SignUpRegisterUser(this.signUpRepository);

  @override
  Future<Either<Failure, User>> call(User data) async {
    // TODO: implement call
    return await signUpRepository.registerUser(data);
  }
}

