// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';

part 'business_profile_model.g.dart';

@JsonSerializable()
class BusinessProfileModel extends BusinessProfile {
  BusinessProfileModel({
    String? id,
    String? name,
    String? email,
    String? contact_number,
    String? status,
    bool? apply_for_verification,
    String? remarks,
    UserModel? user,
    AddCategoryModel? category,
    String? logo,
    List<AttachmentModel>? attachments,
  }) : super(
          id: id,
          name: name,
          email: email,
          contact_number: contact_number,
          status: status,
          apply_for_verification: apply_for_verification,
          remarks: remarks,
          user: user,
          category: category,
          logo: logo,
          attachments: attachments,
        );

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessProfileModelToJson(this);
}
