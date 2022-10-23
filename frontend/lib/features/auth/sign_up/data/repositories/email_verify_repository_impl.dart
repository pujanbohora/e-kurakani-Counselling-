// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/email_verification_remote_data_source.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:frontend/injectable.dart';
import '../../domain/entities/email_verify.dart';
import '../model/verify_email_model.dart';

@Injectable(as: EmailVerficationRepository)
class EmailVerifyRepositoryImpl implements EmailVerficationRepository {
  var emailVerificationRemoteDataSource =
      getIt<EmailVerificationRemoteDataSource>();

  @override
  Future<Either<Failure, EmailVerifyCodeModel>> emailVerification(
      EmailVerifyCode data) async {
    try {
      final verifyEmailUpResponse =
          await emailVerificationRemoteDataSource.emailVerifyUser(data);

      //local get email

      return Right(verifyEmailUpResponse);
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
