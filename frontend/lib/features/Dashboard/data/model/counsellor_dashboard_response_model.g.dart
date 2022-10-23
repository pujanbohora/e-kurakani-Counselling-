// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counsellor_dashboard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounsellorDashboardResponseModel _$CounsellorDashboardResponseModelFromJson(
        Map<String, dynamic> json) =>
    CounsellorDashboardResponseModel(
      upcoming_appointment_count: json['upcoming_appointment_count'] as int?,
      past_appointment_count: json['past_appointment_count'] as int?,
      collected_balance: (json['collected_balance'] as num?)?.toDouble(),
      feedback_count: json['feedback_count'] as int?,
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => UpcomingAppointmentResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CounsellorDashboardResponseModelToJson(
        CounsellorDashboardResponseModel instance) =>
    <String, dynamic>{
      'upcoming_appointment_count': instance.upcoming_appointment_count,
      'past_appointment_count': instance.past_appointment_count,
      'collected_balance': instance.collected_balance,
      'feedback_count': instance.feedback_count,
      'appointments': instance.appointments,
    };
