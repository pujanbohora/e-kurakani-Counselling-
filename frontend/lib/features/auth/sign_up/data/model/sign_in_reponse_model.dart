// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/Sign_in_response.dart';

part 'sign_in_reponse_model.g.dart';


@JsonSerializable()
class SignInResponseModel extends SigninResponse {
  SignInResponseModel({UserModel? user, String? refresh, String? access})
      : super(access: access, refresh: refresh, user: user);

 factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseModelToJson(this);     
}
