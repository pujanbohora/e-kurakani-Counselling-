// Package imports:
import 'package:frontend/features/Dashboard/domain/entity/counsellor_dashboard_response_entity.dart';
import 'package:frontend/features/Dashboard/domain/entity/customer_dashboard_response_entity.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

part 'counsellor_dashboard_response_model.g.dart';

@JsonSerializable()
class CounsellorDashboardResponseModel
    extends CounsellorDashboardResponseEntity {
  CounsellorDashboardResponseModel({
    int? upcoming_appointment_count,
    int? past_appointment_count,
    double? collected_balance,
    int? feedback_count,
    List<UpcomingAppointmentResponseModel>? appointments,
  }) : super(
          upcoming_appointment_count: upcoming_appointment_count,
          past_appointment_count: past_appointment_count,
          collected_balance: collected_balance,
          feedback_count: feedback_count,
          appointments: appointments,
        );

  factory CounsellorDashboardResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$CounsellorDashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CounsellorDashboardResponseModelToJson(this);
}
