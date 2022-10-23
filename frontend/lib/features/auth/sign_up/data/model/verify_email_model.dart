// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';

// part 'user_model.g.dart';

part 'verify_email_model.g.dart';

@JsonSerializable()
class EmailVerifyCodeModel extends EmailVerifyCode {
  const EmailVerifyCodeModel(
      {String? otp, String? message, bool? success, String? email})
      : super(otp: otp, message: message, success: success, email: email);

  factory EmailVerifyCodeModel.fromJson(Map<String, dynamic> json) =>
      _$EmailVerifyCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailVerifyCodeModelToJson(this);
}
