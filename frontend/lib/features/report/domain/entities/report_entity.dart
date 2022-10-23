// Package imports:
import 'package:equatable/equatable.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';

// Project imports:
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class ReportEntity extends Equatable {
  final int? id;
  final UserModel? reported_by;
  final String? report_for;
  final String? title;
  final String? description;
  final UpcomingAppointmentResponseModel? appointment;
  final CounsellorProfileModel? counsellor;

  ReportEntity({
    this.id,
    this.reported_by,
    this.report_for,
    this.title,
    this.description,
    this.appointment,
    this.counsellor,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        reported_by,
        report_for,
        title,
        description,
        appointment,
        counsellor,
      ];
}
