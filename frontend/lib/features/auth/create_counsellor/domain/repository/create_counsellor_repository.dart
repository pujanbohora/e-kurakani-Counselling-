// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

abstract class CreateCounsellorRepository {
  Future<Either<Failure, User>> createCounsellorRepo(User data);
  // Future<Either<Failure, User>> loginWithPassword(User data);
}
