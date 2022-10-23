// Package imports:
import 'package:equatable/equatable.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'dart:io';

// Project imports:
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class CounsellorDashboardResponseEntity extends Equatable {
  final int? upcoming_appointment_count;
  final int? past_appointment_count;
  final double? collected_balance;
  final int? feedback_count;
  final List<UpcomingAppointmentResponseModel>? appointments;
  CounsellorDashboardResponseEntity({
    this.upcoming_appointment_count,
    this.past_appointment_count,
    this.collected_balance,
    this.feedback_count,
    this.appointments,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        upcoming_appointment_count,
        past_appointment_count,
        collected_balance,
        feedback_count,
        appointments,
      ];
}
