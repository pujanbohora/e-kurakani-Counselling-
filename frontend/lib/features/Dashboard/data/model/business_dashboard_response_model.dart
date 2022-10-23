// Package imports:
import 'package:frontend/features/Dashboard/domain/entity/business_dashboard_response_entity.dart';
import 'package:frontend/features/Dashboard/domain/entity/counsellor_dashboard_response_entity.dart';
import 'package:frontend/features/Dashboard/domain/entity/customer_dashboard_response_entity.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

part 'business_dashboard_response_model.g.dart';

@JsonSerializable()
class BusinessDashboardResponseModel extends BusinessDashboardResponseEntity {
  BusinessDashboardResponseModel({
    int? total_counsellor,
    int? total_appointment,
    double? collected_balance,
    int? feedback_count,
    List<CounsellorProfileModel>? counsellors,
  }) : super(
          total_counsellor: total_counsellor,
          total_appointment: total_appointment,
          collected_balance: collected_balance,
          feedback_count: feedback_count,
          counsellors: counsellors,
        );

  factory BusinessDashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessDashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessDashboardResponseModelToJson(this);
}
