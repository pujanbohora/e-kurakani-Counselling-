// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';

abstract class GetScheduleListRepository {
  Future<Either<Failure, List<ScheduleWeekEntities>>> getSheduleList();
  Future<Either<Failure, Map<String, dynamic>>> deleteSchedule(id);
}
