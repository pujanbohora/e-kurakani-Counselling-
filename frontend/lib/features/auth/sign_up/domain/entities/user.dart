// Package imports:
import 'dart:io';

import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_detail_model.dart';

class User extends Equatable {
  String? id;
  String? email;
  String? password;
  String? otp;
  String? user_role;
  bool? is_active;
  bool? is_suspended;
  String? profile_image;
  bool? enrv;
  String? associated_business;
  UserDetailsModel? details;

  User({
    this.id,
    this.email,
    this.user_role,
    this.otp,
    this.password,
    this.is_active,
    this.enrv,
    this.is_suspended,
    this.profile_image,
    this.associated_business,
    this.details,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        password,
        is_active,
        otp,
        is_suspended,
        enrv,
        profile_image,
        associated_business,
        id,
        details,
        
      ];
}
