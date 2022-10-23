import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';

abstract class ForgetPasswordOTPVerifyRepository {
  Future<Either<Failure, String>> otpVerify(
      EmailVerifyCode code);
}
