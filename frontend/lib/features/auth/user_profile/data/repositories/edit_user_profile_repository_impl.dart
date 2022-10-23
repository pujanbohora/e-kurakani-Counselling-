import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';
import 'package:frontend/features/auth/user_profile/data/data_source/edit_user_profile_remote_data_source.dart';
import 'package:frontend/features/auth/user_profile/domain/repository/edit_user_profile_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditUserProfileRepository)
class EditUserProfileRepositoryImpl implements EditUserProfileRepository {

  var editUserProfileRemoteDataSource =
      getIt<EditUserProfileRemoteDataSource>();

  @override
  Future<Either<Failure, UserDetails>> editUserProfile(UserDetails userData) async {
    try {
      print(userData);

      print("object1232222");
      final userResponse =
          await editUserProfileRemoteDataSource.editUserProfile(userData);

      return Right(userResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
