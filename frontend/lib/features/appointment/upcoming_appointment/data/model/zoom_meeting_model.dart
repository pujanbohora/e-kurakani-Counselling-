import 'package:frontend/features/appointment/upcoming_appointment/domain/entity/zoom_meeting_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'zoom_meeting_model.g.dart';

@JsonSerializable()
class ZoomMeetingModel extends ZoomMeeting {
  ZoomMeetingModel({
    String? id,
    String? uuid,
    String? host_id,
    String? host_email,
    String? topic,
    String? type,
    String? status,
    String? start_time,
    String? duration,
    String? timezone,
    String? start_url,
    String? join_url,
    String? password,
  }) : super(
          id: id,
          uuid: uuid,
          host_id: host_id,
          host_email: host_email,
          topic: topic,
          type: type,
          status: status,
          start_time: start_time,
          duration: duration,
          timezone: timezone,
          start_url: start_url,
          join_url: join_url,
          password: password,
        );

  factory ZoomMeetingModel.fromJson(Map<String, dynamic> json) =>
      _$ZoomMeetingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZoomMeetingModelToJson(this);
}
