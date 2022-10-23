// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counsellor_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounsellorProfileModel _$CounsellorProfileModelFromJson(
        Map<String, dynamic> json) =>
    CounsellorProfileModel(
      id: json['id'].toString(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      contact_number: json['contact_number'] as String?,
      status: json['status'] as String?,
      apply_for_verification: json['apply_for_verification'] as bool?,
      remarks: json['remarks'] as String?,
      time_interval: json['time_interval'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : AddCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      is_freelancer: json['is_freelancer'] as bool?,
      available_times: (json['available_times'] as List<dynamic>?)
          ?.map((e) => TimeTableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      associated_business: json['associated_business'] == null
          ? null
          : BusinessProfileModel.fromJson(
              json['associated_business'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CounsellorProfileModelToJson(
        CounsellorProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'contact_number': instance.contact_number,
      'status': instance.status,
      'apply_for_verification': instance.apply_for_verification,
      'remarks': instance.remarks,
      'time_interval': instance.time_interval,
      'available_times': instance.available_times,
      'price': instance.price,
      'user': instance.user,
      'category': instance.category,
      'is_freelancer': instance.is_freelancer,
      'associated_business': instance.associated_business,
      'attachments': instance.attachments,
    };
