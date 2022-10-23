// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_appointment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingAppointmentResponseModel _$UpcomingAppointmentResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpcomingAppointmentResponseModel(
      id: json['id'].toString(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      counsellor: json['counsellor'] == null
          ? null
          : CounsellorProfileModel.fromJson(
              json['counsellor'] as Map<String, dynamic>),
      date: json['date'] as String,
      time: json['time'] as String,
      appointment_meeting: (json['appointment_meeting'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AppointmentMeetingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingAppointmentResponseModelToJson(
        UpcomingAppointmentResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'counsellor': instance.counsellor,
      'date': instance.date,
      'time': instance.time,
      'appointment_meeting': instance.appointment_meeting,
    };
