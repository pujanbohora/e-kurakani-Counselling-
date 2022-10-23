import 'package:frontend/features/appointment/upcoming_appointment/data/model/appointment_meeting_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/entity/upcoming_appointment_response_entity.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_appointment_response_model.g.dart';

@JsonSerializable()
class UpcomingAppointmentResponseModel extends UpcomingAppointmentResponse {
  UpcomingAppointmentResponseModel({
    String? id,
    UserModel? user,
    CounsellorProfileModel? counsellor,
    String? date,
    String? time,
    List<AppointmentMeetingModel?>? appointment_meeting,
  }) : super(
          id: id,
          user: user,
          counsellor: counsellor,
          date: date,
          time: time,
          appointment_meeting: appointment_meeting,
        );

  factory UpcomingAppointmentResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$UpcomingAppointmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpcomingAppointmentResponseModelToJson(this);
}
