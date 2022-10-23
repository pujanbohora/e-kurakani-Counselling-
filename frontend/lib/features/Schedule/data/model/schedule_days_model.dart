import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/features/Schedule/data/model/schedule_time_model.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_days_entities.dart';

part 'schedule_days_model.g.dart';

@JsonSerializable()

class ScheduleDaysModel extends ScheduleDaysEntities {
  ScheduleDaysModel(
      {required super.date, required super.day, required super.time});

  factory ScheduleDaysModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDaysModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDaysModelToJson(this);
}
