// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counsellor_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounsellorFeedbackModel _$CounsellorFeedbackModelFromJson(
        Map<String, dynamic> json) =>
    CounsellorFeedbackModel(
      id: json['id'].toString(),
      appointment: json['appointment'] == null
          ? null
          : UpcomingAppointmentResponseModel.fromJson(
              json['appointment'] as Map<String, dynamic>),
      feedback_by: json['feedback_by'] == null
          ? null
          : UserModel.fromJson(json['feedback_by'] as Map<String, dynamic>),
      counsellor: json['counsellor'] == null
          ? null
          : CounsellorProfileModel.fromJson(
              json['counsellor'] as Map<String, dynamic>),
      feedback_for: json['feedback_for'] as String?,
      star: (json['star'] as num?)?.toDouble(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CounsellorFeedbackModelToJson(
        CounsellorFeedbackModel instance) =>
    <String, dynamic>{
      'counsellor': instance.counsellor,
      'id': instance.id,
      'feedback_for': instance.feedback_for,
      'star': instance.star,
      'message': instance.message,
      'appointment': instance.appointment,
      'feedback_by': instance.feedback_by,
    };
