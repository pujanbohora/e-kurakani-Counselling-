
import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/data/data_sources/check_user_status_remote_data_source.dart';
import 'package:frontend/features/auth/user/domain/repository/check_user_status_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckUserStatusRepository)
class CheckUserStatusRepositoryImpl implements CheckUserStatusRepository {
  var checkUserStatusRemoteDataSource =
      getIt<CheckUserStatusRemoteDataSource>();
  @override
  Future<Either<Failure, User>> checkStatus(data) async {
    try {
      final userListResponse =
          await checkUserStatusRemoteDataSource.checkStatus(data);

      return Right(userListResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
