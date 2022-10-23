// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestModel _$CreateRequestModelFromJson(Map<String, dynamic> json) =>
    CreateRequestModel(
      user: json['user'] as String?,
      counsellor: json['counsellor'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$CreateRequestModelToJson(CreateRequestModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'counsellor': instance.counsellor,
      'date': instance.date,
      'time': instance.time,
      'remarks': instance.remarks,
    };
