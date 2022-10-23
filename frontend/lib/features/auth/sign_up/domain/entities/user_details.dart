// Package imports:
import 'dart:io';

import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String? id;
  final String? full_name;
  final String? bio;
  final String? gender;
  final String? profile_image;
  final String? date_of_birth;
  final String? contact_number;
  final File? fileData;

  UserDetails(
      {this.id,
      this.full_name,
      this.profile_image,
      this.bio,
      this.gender,
      this.date_of_birth,
      this.contact_number,
      this.fileData});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        full_name,
        bio,
        gender,
        date_of_birth,
        contact_number,
        profile_image,
        fileData
      ];
}
