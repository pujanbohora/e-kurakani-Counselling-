// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_dashboard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessDashboardResponseModel _$BusinessDashboardResponseModelFromJson(
        Map<String, dynamic> json) =>
    BusinessDashboardResponseModel(
      total_counsellor: json['total_counsellor'] as int?,
      total_appointment: json['total_appointment'] as int?,
      collected_balance: (json['collected_balance'] as num?)?.toDouble(),
      feedback_count: json['feedback_count'] as int?,
      counsellors: (json['counsellors'] as List<dynamic>?)
          ?.map(
              (e) => CounsellorProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessDashboardResponseModelToJson(
        BusinessDashboardResponseModel instance) =>
    <String, dynamic>{
      'total_counsellor': instance.total_counsellor,
      'total_appointment': instance.total_appointment,
      'collected_balance': instance.collected_balance,
      'feedback_count': instance.feedback_count,
      'counsellors': instance.counsellors,
    };
