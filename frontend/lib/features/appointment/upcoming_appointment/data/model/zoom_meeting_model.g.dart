// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zoom_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoomMeetingModel _$ZoomMeetingModelFromJson(Map<String, dynamic> json) =>
    ZoomMeetingModel(
      id: json['id'].toString(),
      uuid: json['uuid'] as String?,
      host_id: json['host_id'] as String?,
      host_email: json['host_email'] as String?,
      topic: json['topic'] as String?,
      type: json['type'].toString(),
      status: json['status'] as String?,
      start_time: json['start_time'] as String?,
      duration: json['duration'].toString(),
      timezone: json['timezone'] as String?,
      start_url: json['start_url'] as String?,
      join_url: json['join_url'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$ZoomMeetingModelToJson(ZoomMeetingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'host_id': instance.host_id,
      'host_email': instance.host_email,
      'topic': instance.topic,
      'type': instance.type,
      'status': instance.status,
      'start_time': instance.start_time,
      'duration': instance.duration,
      'timezone': instance.timezone,
      'start_url': instance.start_url,
      'join_url': instance.join_url,
      'password': instance.password,
    };
