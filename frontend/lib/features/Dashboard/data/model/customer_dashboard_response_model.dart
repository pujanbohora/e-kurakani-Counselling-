// Package imports:
import 'package:frontend/features/Dashboard/domain/entity/customer_dashboard_response_entity.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

part 'customer_dashboard_response_model.g.dart';

@JsonSerializable()
class CustomerDashboardResponseModel extends CustomerDashboardResponseEntity {
  CustomerDashboardResponseModel({
    List<AddCategoryModel>? categories,
    List<CounsellorProfileModel>? counsellors,
  }) : super(
          categories: categories,
          counsellors: counsellors,
        );

  factory CustomerDashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerDashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDashboardResponseModelToJson(this);
}
