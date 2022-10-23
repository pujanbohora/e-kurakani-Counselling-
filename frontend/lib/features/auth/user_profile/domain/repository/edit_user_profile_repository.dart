import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';

abstract class EditUserProfileRepository {
  Future<Either<Failure, UserDetails>> editUserProfile(UserDetails userData);
}
