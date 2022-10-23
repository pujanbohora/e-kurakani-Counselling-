import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/user/data/data_sources/get_user_details_list_remote_data_source.dart';
import 'package:frontend/features/auth/user/domain/repository/get_user_details_list_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: GetUserDetailsListRepository)
class GetUserDetailsListRepositoryImpl implements GetUserDetailsListRepository {
  var getUserDetailsListRemoteDataSource =
      getIt<GetUserDetailsListRemoteDataSource>();
  @override
  Future<Either<Failure, List<User>>> getUserDetailsList() async {
    try {
      final userListResponse =
          await getUserDetailsListRemoteDataSource.getUserDetailsList();

      return Right(userListResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
