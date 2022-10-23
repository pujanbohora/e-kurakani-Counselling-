// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as int?,
      reported_by: json['reported_by'] == null
          ? null
          : UserModel.fromJson(json['reported_by'] as Map<String, dynamic>),
      report_for: json['report_for'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      appointment: json['appointment'] == null
          ? null
          : UpcomingAppointmentResponseModel.fromJson(
              json['appointment'] as Map<String, dynamic>),
      counsellor: json['counsellor'] == null
          ? null
          : CounsellorProfileModel.fromJson(
              json['counsellor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reported_by': instance.reported_by,
      'report_for': instance.report_for,
      'title': instance.title,
      'description': instance.description,
      'appointment': instance.appointment,
      'counsellor': instance.counsellor,
    };
