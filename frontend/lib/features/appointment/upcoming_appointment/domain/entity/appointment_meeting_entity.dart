import 'package:equatable/equatable.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/zoom_meeting_model.dart';

class AppointmentMeeting extends Equatable {
  final String? id;
  final String? status;
  final String? invitation_url;
  final String? zoom_meeting_id;
  final String? start_time;
  final String? start_meeting_url;
  final String? join_meeting_url;
  final ZoomMeetingModel? zoom_meeting;

  AppointmentMeeting({
    this.id,
    this.status,
    this.invitation_url,
    this.zoom_meeting_id,
    this.start_time,
    this.start_meeting_url,
    this.join_meeting_url,
    this.zoom_meeting,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        status,
        invitation_url,
        zoom_meeting_id,
        start_time,
        start_meeting_url,
        join_meeting_url,
        zoom_meeting,
      ];
}
