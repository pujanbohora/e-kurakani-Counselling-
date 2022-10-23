// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleWeekModel _$ScheduleWeekModelFromJson(Map<String, dynamic> json) =>
    ScheduleWeekModel(
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => ScheduleDaysModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      week: json['week'] as String?,
    );

Map<String, dynamic> _$ScheduleWeekModelToJson(ScheduleWeekModel instance) =>
    <String, dynamic>{
      'week': instance.week,
      'days': instance.days,
    };
