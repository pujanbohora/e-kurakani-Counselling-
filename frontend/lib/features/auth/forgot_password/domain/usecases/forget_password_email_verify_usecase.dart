import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_email_verify_repository.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordEmailVerification implements Usecase<bool, UserModel> {

  var forgetPasswordEmailVerficationRepository =
      getIt<ForgetPasswordEmailVerficationRepository>();

  @override
  Future<Either<Failure, bool>> call(UserModel data) async {
    // TODO: implement call
    return await forgetPasswordEmailVerficationRepository.emailVerify(data);
  }
}
