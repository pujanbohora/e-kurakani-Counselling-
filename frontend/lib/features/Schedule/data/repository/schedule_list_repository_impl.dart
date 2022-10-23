// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/Schedule/data/data_source/schedule_list_remote_data_source.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:frontend/features/Schedule/domain/repository/shedule_list_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: GetScheduleListRepository)
class GetScheduleListRepositoryImpl implements GetScheduleListRepository {
  var getScheduleListRemoteDataSource =
      getIt<GetScheduleListRemoteDataSource>();

  @override
  Future<Either<Failure, List<ScheduleWeekEntities>>> getSheduleList() async {
    try {
      final getScheduleListResponse =
          await getScheduleListRemoteDataSource.getSheduleList();

      //local get email

      return Right(getScheduleListResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteSchedule(id) async {
    try {
      final deleteScheduleResponse =
          await getScheduleListRemoteDataSource.deleteSchedule(id);

      //local get email

      return Right(deleteScheduleResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(User data) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
