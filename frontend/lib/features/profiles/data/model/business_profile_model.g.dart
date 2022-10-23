// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessProfileModel _$BusinessProfileModelFromJson(
        Map<String, dynamic> json) =>
    BusinessProfileModel(
      id: json['id'].toString(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      contact_number: json['contact_number'] as String?,
      status: json['status'] as String?,
      apply_for_verification: json['apply_for_verification'] as bool?,
      remarks: json['remarks'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : AddCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      logo: json['logo'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessProfileModelToJson(
        BusinessProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'contact_number': instance.contact_number,
      'status': instance.status,
      'apply_for_verification': instance.apply_for_verification,
      'remarks': instance.remarks,
      'user': instance.user,
      'category': instance.category,
      'logo': instance.logo,
      'attachments': instance.attachments,
    };
