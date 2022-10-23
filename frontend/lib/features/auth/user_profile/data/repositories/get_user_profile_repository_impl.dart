import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/user/data/data_sources/get_user_details_list_remote_data_source.dart';
import 'package:frontend/features/auth/user_profile/data/data_source/get_user_profile_remote_data_source.dart';
import 'package:frontend/features/auth/user_profile/domain/repository/get_user_profile_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetUserProfileRepository)
class GetUserProfileRepositoryImpl implements GetUserProfileRepository {
  var getUserProfileRemoteDataSource = getIt<GetUserProfileRemoteDataSource>();

  @override
  Future<Either<Failure, User>> getUserProfile(String id) async {
    try {
      final userResponse =
          await getUserProfileRemoteDataSource.getUserProfile(id);

      return Right(userResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
