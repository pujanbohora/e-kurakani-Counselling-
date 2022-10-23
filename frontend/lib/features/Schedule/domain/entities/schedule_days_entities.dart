import 'package:equatable/equatable.dart';
import 'package:frontend/features/Schedule/data/model/schedule_time_model.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_time_entities.dart';

class ScheduleDaysEntities extends Equatable {
  final String? date;
  final String? day;
  List<ScheduleTimeModel>? time;

  ScheduleDaysEntities(
      {required this.date, required this.day, required this.time});
  @override
  // TODO: implement props
  List<Object?> get props => [date, day, time];
}
