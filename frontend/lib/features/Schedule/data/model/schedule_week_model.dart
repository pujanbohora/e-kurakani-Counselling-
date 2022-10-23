import 'package:frontend/features/Schedule/data/model/schedule_days_model.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_week_model.g.dart';

@JsonSerializable()
class ScheduleWeekModel extends ScheduleWeekEntities {
  ScheduleWeekModel({required super.days, required super.week});

  factory ScheduleWeekModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleWeekModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleWeekModelToJson(this);
}
