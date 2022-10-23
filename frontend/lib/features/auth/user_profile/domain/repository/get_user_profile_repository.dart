import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

abstract class GetUserProfileRepository {
  Future<Either<Failure, User>> getUserProfile(String id);
}
