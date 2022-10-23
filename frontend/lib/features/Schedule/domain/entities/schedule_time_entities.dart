import 'package:equatable/equatable.dart';

class ScheduleTimeEntities extends Equatable {
  final int? id;
  final String? start_time;
  final String? end_time;

  ScheduleTimeEntities({
    required this.id,
    required this.start_time,
    required this.end_time,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        start_time,
        end_time,
      ];
}
