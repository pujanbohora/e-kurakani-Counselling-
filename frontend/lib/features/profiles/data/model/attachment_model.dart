// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'dart:io';

import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel extends ProfileAttachments {
  AttachmentModel({
    String? id,
    CounsellorProfileModel? counsellor_profile,
    BusinessProfileModel? business_profile,
    String? label,
    String? file,
    String? remarks,
    // File? fileData,
  }) : super(
          id: id,
          counsellor_profile: counsellor_profile,
          business_profile: business_profile,
          label: label,
          file: file,
          remarks: remarks,
          // fileData: fileData,
        );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
