import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

abstract class DeleteUserRepository {
  Future<Either<Failure, Map<String, dynamic>>> deleteUser(User data);
}
