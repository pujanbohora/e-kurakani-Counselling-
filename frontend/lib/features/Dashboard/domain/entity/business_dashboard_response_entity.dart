// Package imports:
import 'package:equatable/equatable.dart';
import 'dart:io';

// Project imports:
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class BusinessDashboardResponseEntity extends Equatable {
  final int? total_counsellor;
  final int? total_appointment;
  final double? collected_balance;
  final int? feedback_count;
  final List<CounsellorProfileModel>? counsellors;
  BusinessDashboardResponseEntity({
    this.total_counsellor,
    this.total_appointment,
    this.collected_balance,
    this.feedback_count,
    this.counsellors,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        total_counsellor,
        total_appointment,
        collected_balance,
        feedback_count,
        counsellors,
      ];
}
