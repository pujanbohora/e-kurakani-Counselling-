import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_otp_repository.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordOTPVerifyUsecase implements Usecase<String, EmailVerifyCode> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var forgetPasswordOTPVerifyRepository =
      getIt<ForgetPasswordOTPVerifyRepository>();

  @override
  Future<Either<Failure, String>> call(EmailVerifyCode data) async {
    // TODO: implement call
    return await forgetPasswordOTPVerifyRepository.otpVerify(data);
  }
}
