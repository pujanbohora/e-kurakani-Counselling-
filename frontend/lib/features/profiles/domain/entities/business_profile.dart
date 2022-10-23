// Package imports:
import 'dart:io';

import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';

class BusinessProfile extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? contact_number;
  final String? status;
  final bool? apply_for_verification;
  final String? remarks;
  final UserModel? user;
  final AddCategoryModel? category;
  final String? logo;
  final List<AttachmentModel>? attachments;
  final List<ProfileAttachments>? profile_attachments;
  final File? logoData;

  BusinessProfile({
    this.id,
    this.name,
    this.email,
    this.contact_number,
    this.status,
    this.apply_for_verification,
    this.remarks,
    this.user,
    this.category,
    this.logo,
    this.attachments,
    this.profile_attachments,
    this.logoData,
  });

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
        logo,
        attachments,
        profile_attachments,
        logoData,
      ];
}
