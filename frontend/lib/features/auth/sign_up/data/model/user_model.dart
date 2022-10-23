// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_detail_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel(
      {String? id,
      String? email,
      String? otp,
      String? user_role,
      String? password,
      bool? is_active,
      bool? enrv,
      bool? is_suspended,
      String? profile_image,
      String? associated_business,
      UserDetailsModel? details})
      : super(
            email: email,
            otp: otp,
            user_role: user_role,
            password: password,
            is_active: is_active,
            is_suspended: is_suspended,
            enrv: enrv,
            profile_image: profile_image,
            id: id,
            associated_business: associated_business,
            details: details);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
