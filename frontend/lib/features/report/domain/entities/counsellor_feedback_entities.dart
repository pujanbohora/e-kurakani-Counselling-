import 'package:equatable/equatable.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class CounsellorFeedbackEntities extends Equatable {
  final CounsellorProfileModel? counsellor;
  // final String? counsellor_id;
  final String? id;
  final String? feedback_for;
  final double? star;
  final String? message;

  final UpcomingAppointmentResponseModel? appointment;
  // final String? appointment_id;
  final UserModel? feedback_by;

  CounsellorFeedbackEntities(
      {this.id,
      this.appointment,
      this.feedback_by,
      this.counsellor,
      this.feedback_for,
      this.star,
      this.message});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [appointment, feedback_by, counsellor, feedback_for, star, message];
}
