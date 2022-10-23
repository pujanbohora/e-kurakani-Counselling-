import 'package:frontend/features/appointment/upcoming_appointment/data/model/zoom_meeting_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/entity/appointment_meeting_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_meeting_model.g.dart';

@JsonSerializable()
class AppointmentMeetingModel extends AppointmentMeeting {
  AppointmentMeetingModel({
    String? id,
    String? status,
    String? invitation_url,
    String? zoom_meeting_id,
    String? start_time,
    String? start_meeting_url,
    String? join_meeting_url,
    ZoomMeetingModel? zoom_meeting,
  }) : super(
            id: id,
            status: status,
            invitation_url: invitation_url,
            zoom_meeting_id: zoom_meeting_id,
            start_time: start_time,
            start_meeting_url: start_meeting_url,
            join_meeting_url: join_meeting_url,
            zoom_meeting: zoom_meeting);

  factory AppointmentMeetingModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentMeetingModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentMeetingModelToJson(this);
}
