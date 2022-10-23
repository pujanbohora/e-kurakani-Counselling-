import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';

abstract class ForgetPasswordEmailVerficationRepository {
  Future<Either<Failure, bool>> emailVerify(
      UserModel data);
}
