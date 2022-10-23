// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableModel _$TimeTableModelFromJson(Map<String, dynamic> json) =>
    TimeTableModel(
      id: json['id'].toString(),
      month: json['month'] as String?,
      date: json['date'] as String?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      intervals: (json['intervals'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      counsellor: json['counsellor'] == null
          ? null
          : CounsellorProfileModel.fromJson(
              json['counsellor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeTableModelToJson(TimeTableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'month': instance.month,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'intervals': instance.intervals,
      'counsellor': instance.counsellor,
    };
