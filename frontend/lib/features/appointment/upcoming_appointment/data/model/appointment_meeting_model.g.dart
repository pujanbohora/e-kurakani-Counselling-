// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentMeetingModel _$AppointmentMeetingModelFromJson(
        Map<String, dynamic> json) =>
    AppointmentMeetingModel(
      id: json['id'].toString(),
      status: json['status'] as String?,
      invitation_url: json['invitation_url'] as String?,
      zoom_meeting_id: json['zoom_meeting_id'] as String?,
      start_time: json['start_time'] as String?,
      start_meeting_url: json['start_meeting_url'] as String?,
      join_meeting_url: json['join_meeting_url'] as String?,
      zoom_meeting: json['zoom_meeting'] == null
          ? null
          : ZoomMeetingModel.fromJson(
              json['zoom_meeting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentMeetingModelToJson(
        AppointmentMeetingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'invitation_url': instance.invitation_url,
      'zoom_meeting_id': instance.zoom_meeting_id,
      'start_time': instance.start_time,
      'start_meeting_url': instance.start_meeting_url,
      'join_meeting_url': instance.join_meeting_url,
      'zoom_meeting': instance.zoom_meeting,
    };
