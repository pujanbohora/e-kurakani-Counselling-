// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/forgot_password/data/data_source/forget_password_reset_password_remote_data_source.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_reset_password_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: ForgetPasswordResetPasswordRepository)

class ForgetPasswordResetPasswordImpl
    implements ForgetPasswordResetPasswordRepository {

  var forgetPasswordResetPasswordRemoteDataSource =
      getIt<ForgetPasswordResetPasswordRemoteDataSource>();

  @override
  Future<Either<Failure, bool>> changePassword(User data) async {
    try {
      final response =
          await forgetPasswordResetPasswordRemoteDataSource
              .changePassword(data);

      //local get email

      return Right(response);
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
