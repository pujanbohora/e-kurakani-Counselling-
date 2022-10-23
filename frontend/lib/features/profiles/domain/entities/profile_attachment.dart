// Package imports:
import 'dart:io';

import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class ProfileAttachments extends Equatable {
  final String? id;
  final CounsellorProfileModel? counsellor_profile;
  final BusinessProfileModel? business_profile;
  final String? label;
  final String? file;
  final String? remarks;
  final File? fileData;

  ProfileAttachments({
    this.id,
    this.counsellor_profile,
    this.business_profile,
    this.label,
    this.file,
    this.remarks,
    this.fileData,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        counsellor_profile,
        business_profile,
        label,
        file,
        remarks,
        fileData,
      ];
}
