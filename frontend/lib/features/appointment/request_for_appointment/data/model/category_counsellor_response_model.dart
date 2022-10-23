// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

part 'category_counsellor_response_model.g.dart';

@JsonSerializable()

class CategoryCounsellorResponseModel extends CategoryCounsellorResponse {
  const CategoryCounsellorResponseModel(String? id, String? name,
      List<CounsellorProfileModel>? counsellors)
      : super(id, name, counsellors);

  factory CategoryCounsellorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryCounsellorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryCounsellorResponseModelToJson(this);    
}
