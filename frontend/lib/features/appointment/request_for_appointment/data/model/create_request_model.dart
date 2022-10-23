// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';

part 'create_request_model.g.dart';

@JsonSerializable()
class CreateRequestModel extends CreateRequestEntiry {
  const CreateRequestModel(
      {String? user,
      String? counsellor,
      String? date,
      String? time, String? remarks})
      : super(
            user: user,
            counsellor: counsellor,
            date: date,
            time: time, 
            remarks: remarks);

  factory CreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestModelToJson(this);           
}
