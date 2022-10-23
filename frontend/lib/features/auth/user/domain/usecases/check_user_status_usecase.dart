import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/repository/check_user_status_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckUserStatusUsecase implements Usecase<User, User> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var emailVerficationRepository = getIt<CheckUserStatusRepository>();

  @override
  Future<Either<Failure, User>> call(User data) async {
    // TODO: implement call
    return await emailVerficationRepository.checkStatus(data);
  }
}
