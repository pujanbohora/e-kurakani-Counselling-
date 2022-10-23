// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      id: json['id'].toString(),
      full_name: json['full_name'] as String?,
      profile_image: json['profile_image'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      date_of_birth: json['date_of_birth'] as String?,
      contact_number: json['contact_number'] as String?,
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'bio': instance.bio,
      'gender': instance.gender,
      'profile_image': instance.profile_image,
      'date_of_birth': instance.date_of_birth,
      'contact_number': instance.contact_number,
    };
