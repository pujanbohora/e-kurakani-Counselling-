// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTimeModel _$ScheduleTimeModelFromJson(Map<String, dynamic> json) =>
    ScheduleTimeModel(
      id: json['id'] as int?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
    );

Map<String, dynamic> _$ScheduleTimeModelToJson(ScheduleTimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
    };
