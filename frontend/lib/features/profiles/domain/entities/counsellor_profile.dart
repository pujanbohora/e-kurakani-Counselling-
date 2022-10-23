// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/data/model/timetable_model.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';

class CounsellorProfile extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? contact_number;
  final String? status;
  final bool? apply_for_verification;
  final String? remarks;
  final int? time_interval;
  List<TimeTableModel>? available_times;
  final double? price;
  final UserModel? user;
  final AddCategoryModel? category;
  final bool? is_freelancer;
  final BusinessProfileModel? associated_business;
  final List<AttachmentModel>? attachments;
  final List<ProfileAttachments>? profile_attachments;

  CounsellorProfile(
      {this.id,
      this.name,
      this.email,
      this.contact_number,
      this.status,
      this.apply_for_verification,
      this.remarks,
      this.price,
      this.time_interval,
      this.user,
      this.category,
      this.is_freelancer,
      this.associated_business,
      this.attachments,
      this.profile_attachments,
      this.available_times});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        email,
        contact_number,
        status,
        apply_for_verification,
        remarks,
        user,
        category,
        is_freelancer,
        associated_business,
        attachments,
        profile_attachments,
        available_times
      ];
}
