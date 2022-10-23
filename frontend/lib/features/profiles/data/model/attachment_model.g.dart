// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: json['id'].toString(),
      counsellor_profile: json['counsellor_profile'] == null
          ? null
          : CounsellorProfileModel.fromJson(
              json['counsellor_profile'] as Map<String, dynamic>),
      business_profile: json['business_profile'] == null
          ? null
          : BusinessProfileModel.fromJson(
              json['business_profile'] as Map<String, dynamic>),
      label: json['label'] as String?,
      file: json['file'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'counsellor_profile': instance.counsellor_profile,
      'business_profile': instance.business_profile,
      'label': instance.label,
      'file': instance.file,
      'remarks': instance.remarks,
    };
