// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import '../entities/email_verify.dart';

abstract class SignUpRepository {
  Future<Either<Failure, User>> registerUser(User data);
  Future<Either<Failure, User>> loginWithPassword(User data);
}

abstract class EmailVerficationRepository {
  Future<Either<Failure, EmailVerifyCode>> emailVerification(
      EmailVerifyCode code);
}
