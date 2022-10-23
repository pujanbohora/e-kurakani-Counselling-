import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_time_entities.dart';

part 'schedule_time_model.g.dart';

@JsonSerializable()
class ScheduleTimeModel extends ScheduleTimeEntities {
  ScheduleTimeModel({
    required super.id,
    required super.start_time,
    required super.end_time,
  });

  factory ScheduleTimeModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTimeModelToJson(this);
}
