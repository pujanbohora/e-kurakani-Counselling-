// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/forgot_password/data/data_source/forget_password_otp_verify_remote_data_source.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_otp_repository.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: ForgetPasswordOTPVerifyRepository)
class ForgetPasswordEmailVerifyRepositoryImpl
    implements ForgetPasswordOTPVerifyRepository {

  var forgetPasswordOTPVerifyRemoteDataSource =
      getIt<ForgetPasswordOTPVerifyRemoteDataSource>();

  @override
  Future<Either<Failure, String>> otpVerify(EmailVerifyCode data) async {
    try {
      final verifyOtpResponse =
          await forgetPasswordOTPVerifyRemoteDataSource.otpVerify(data);

      //local get email

      return Right(verifyOtpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
