import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'counsellor_feedback_model.g.dart';

@JsonSerializable()
class CounsellorFeedbackModel extends CounsellorFeedbackEntities {
  CounsellorFeedbackModel(
      {super.id,
      super.appointment,
      super.feedback_by,
      super.counsellor,
      super.feedback_for,
      super.star,
      super.message});

  factory CounsellorFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$CounsellorFeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$CounsellorFeedbackModelToJson(this);
}
