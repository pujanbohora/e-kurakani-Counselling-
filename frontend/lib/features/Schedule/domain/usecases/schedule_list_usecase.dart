// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:frontend/features/Schedule/domain/repository/shedule_list_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:frontend/injectable.dart';

// ignore: unused_import

@injectable
class GetScheduleListUsecase
    implements Usecase<List<ScheduleWeekEntities>, NoParams> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var getScheduleListRepository = getIt<GetScheduleListRepository>();

  @override
  Future<Either<Failure, List<ScheduleWeekEntities>>> call(
      NoParams data) async {
    // TODO: implement call
    return await getScheduleListRepository.getSheduleList();
  }
}

@injectable
class DeleteScheduleUseCase implements Usecase<Map<String, dynamic>, String> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var getScheduleListRepository = getIt<GetScheduleListRepository>();

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String id) async {
    // TODO: implement call
    return await getScheduleListRepository.deleteSchedule(id);
  }
}
