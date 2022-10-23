import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/forgot_password/domain/repository/forget_password_reset_password_repository.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordResetPasswordUsecase implements Usecase<bool, User> {
  
  var forgetPasswordResetPasswordRepository =
      getIt<ForgetPasswordResetPasswordRepository>();

  @override
  Future<Either<Failure, bool>> call(User data) async {
    // TODO: implement call
    return await forgetPasswordResetPasswordRepository.changePassword(data);
  }
}
