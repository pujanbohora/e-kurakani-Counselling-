import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/data/data_sources/check_user_status_remote_data_source.dart';
import 'package:frontend/features/auth/user/data/data_sources/delete_user_remote_data_source.dart';
import 'package:frontend/features/auth/user/domain/repository/delete_user_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteUserRepository)
class DeleteUserRepositoryImpl implements DeleteUserRepository {
  var deleteUserRemoteDataSource = getIt<DeleteUserRemoteDataSource>();

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteUser(data) async {
    try {
      final deleteResponse = await deleteUserRemoteDataSource.deleteUser(data);

      return Right(deleteResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
