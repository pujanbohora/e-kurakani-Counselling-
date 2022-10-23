// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'].toString(),
      email: json['email'] as String?,
      otp: json['otp'] as String?,
      user_role: json['user_role'] as String?,
      password: json['password'] as String?,
      is_active: json['is_active'] as bool?,
      enrv: json['enrv'] as bool?,
      is_suspended: json['is_suspended'] as bool?,
      profile_image: json['profile_image'] as String?,
      associated_business: json['associated_business'] as String?,
      details: json['details'] == null
          ? null
          : UserDetailsModel.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
      'user_role': instance.user_role,
      'is_active': instance.is_active,
      'is_suspended': instance.is_suspended,
      'profile_image': instance.profile_image,
      'enrv': instance.enrv,
      'associated_business': instance.associated_business,
      'details': instance.details,
    };
