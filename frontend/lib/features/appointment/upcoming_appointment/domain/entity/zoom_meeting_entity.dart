import 'package:equatable/equatable.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class ZoomMeeting extends Equatable {
  final String? id;
  final String? uuid;
  final String? host_id;
  final String? host_email;
  final String? topic;
  final String? type;
  final String? status;
  final String? start_time;
  final String? duration;
  final String? timezone;
  final String? start_url;
  final String? join_url;
  final String? password;

  ZoomMeeting({
    this.id,
    this.uuid,
    this.host_id,
    this.host_email,
    this.topic,
    this.type,
    this.status,
    this.start_time,
    this.duration,
    this.timezone,
    this.start_url,
    this.join_url,
    this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        uuid,
        host_id,
        host_email,
        topic,
        type,
        status,
        start_time,
        duration,
        timezone,
        start_url,
        join_url,
        password,
      ];
}
