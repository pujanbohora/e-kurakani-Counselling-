// Package imports:
import 'package:frontend/features/profiles/data/model/timetable_model.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';

part 'counsellor_profile_model.g.dart';

@JsonSerializable()
class CounsellorProfileModel extends CounsellorProfile {
  CounsellorProfileModel({
    String? id,
    String? name,
    String? email,
    String? contact_number,
    String? status,
    bool? apply_for_verification,
    String? remarks,
    int? time_interval,
    double? price,
    UserModel? user,
    AddCategoryModel? category,
    bool? is_freelancer,
    List<TimeTableModel>? available_times,
    BusinessProfileModel? associated_business,
    List<AttachmentModel>? attachments,
  }) : super(
            id: id,
            name: name,
            email: email,
            contact_number: contact_number,
            status: status,
            apply_for_verification: apply_for_verification,
            remarks: remarks,
            time_interval: time_interval,
            price: price,
            user: user,
            category: category,
            is_freelancer: is_freelancer,
            associated_business: associated_business,
            attachments: attachments,
            available_times: available_times);

  factory CounsellorProfileModel.fromJson(Map<String, dynamic> json) =>
      _$CounsellorProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$CounsellorProfileModelToJson(this);
}
