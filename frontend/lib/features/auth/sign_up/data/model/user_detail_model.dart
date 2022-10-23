// Package imports:
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailsModel extends UserDetails {
  UserDetailsModel({
    String? id,
    String? full_name,
    String? profile_image,
    String? bio,
    String? gender,
    String? date_of_birth,
    String? contact_number,
  }) : super(
          id: id,
          full_name: full_name,
          profile_image: profile_image,
          bio: bio,
          gender: gender,
          date_of_birth: date_of_birth,
          contact_number: contact_number,
        );

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
