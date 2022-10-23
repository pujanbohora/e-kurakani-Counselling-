// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:frontend/injectable.dart';
import '../entities/email_verify.dart';

// ignore: unused_import

@injectable
class EmailVerification implements Usecase<EmailVerifyCode, EmailVerifyCode> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var emailVerficationRepository = getIt<EmailVerficationRepository>();

  @override
  Future<Either<Failure, EmailVerifyCode>> call(EmailVerifyCode data) async {
    // TODO: implement call
    return await emailVerficationRepository.emailVerification(data);
  }
}
