// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailVerifyCodeModel _$EmailVerifyCodeModelFromJson(
        Map<String, dynamic> json) =>
    EmailVerifyCodeModel(
      otp: json['otp'] as String?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EmailVerifyCodeModelToJson(
        EmailVerifyCodeModel instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'message': instance.message,
      'success': instance.success,
      'email': instance.email,
    };
