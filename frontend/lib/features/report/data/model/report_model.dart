// Package imports:
import 'package:frontend/features/appointment/upcoming_appointment/data/model/appointment_meeting_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel extends ReportEntity {
  ReportModel({
    int? id,
    UserModel? reported_by,
    String? report_for,
    String? title,
    String? description,
    UpcomingAppointmentResponseModel? appointment,
    CounsellorProfileModel? counsellor,
  }) : super(
          id: id,
          reported_by: reported_by,
          report_for: report_for,
          title: title,
          description: description,
          appointment: appointment,
          counsellor: counsellor,
        );

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
