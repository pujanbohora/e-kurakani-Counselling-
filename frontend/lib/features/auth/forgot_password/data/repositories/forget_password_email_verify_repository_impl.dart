// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/forgot_password/data/data_source/forget_password_email_verify_remote_data_source.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_email_verify_repository.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: ForgetPasswordEmailVerficationRepository)
class ForgetPasswordEmailVerifyRepositoryImpl
    implements ForgetPasswordEmailVerficationRepository {

  var forgetpasswordemailVerificationRemoteDataSource =
      getIt<ForgetPasswordEmailVerificationRemoteDataSource>();

  @override
  Future<Either<Failure, bool>> emailVerify(
      UserModel data) async {
    try {
      final forgetPasswordVerifyEmailUpResponse =
          await forgetpasswordemailVerificationRemoteDataSource
              .emailVerify(data);

      //local get email

      return Right(forgetPasswordVerifyEmailUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(User data) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
