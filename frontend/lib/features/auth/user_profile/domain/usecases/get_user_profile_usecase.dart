import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user_profile/domain/repository/get_user_profile_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserProfileUsecase implements Usecase<User, String> {
  var getUserProfileRepository = getIt<GetUserProfileRepository>();
  @override
  Future<Either<Failure, User>> call(String id) async {
    // TODO: implement call
    return await getUserProfileRepository.getUserProfile(id);
  }
}
