import 'package:equatable/equatable.dart';
import 'package:frontend/features/Schedule/data/model/schedule_days_model.dart';

class ScheduleWeekEntities extends Equatable {

  final String? week;
  List<ScheduleDaysModel>? days;

  ScheduleWeekEntities({required this.days, required this.week});
  @override
  // TODO: implement props
  List<Object?> get props => [days, week];
}
