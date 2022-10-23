// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_days_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDaysModel _$ScheduleDaysModelFromJson(Map<String, dynamic> json) =>
    ScheduleDaysModel(
      date: json['date'] as String?,
      day: json['day'] as String?,
      time: (json['time'] as List<dynamic>?)
          ?.map((e) => ScheduleTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleDaysModelToJson(ScheduleDaysModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day': instance.day,
      'time': instance.time,
    };
