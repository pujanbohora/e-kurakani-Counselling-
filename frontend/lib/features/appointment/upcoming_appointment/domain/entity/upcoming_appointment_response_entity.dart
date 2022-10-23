import 'package:equatable/equatable.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/appointment_meeting_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class UpcomingAppointmentResponse extends Equatable {
  final String? id;
  final UserModel? user;
  final CounsellorProfileModel? counsellor;
  final String? date;
  final String? time;
  final List<AppointmentMeetingModel?>? appointment_meeting;

  UpcomingAppointmentResponse({
    required this.id,
    required this.user,
    required this.counsellor,
    this.date,
    this.time,
    this.appointment_meeting,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, user, counsellor, appointment_meeting];
}
