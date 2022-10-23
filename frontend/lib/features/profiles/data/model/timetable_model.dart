// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';

part 'timetable_model.g.dart';

@JsonSerializable()
class TimeTableModel extends CounsellorTimeTable {
  TimeTableModel({
    String? id,
    String? month,
    String? date,
    String? start_time,
    String? end_time,
    List<String?>? intervals,
    CounsellorProfileModel? counsellor,
  }) : super(
            id: id,
            month: month,
            date: date,
            start_time: start_time,
            end_time: end_time,
            counsellor: counsellor,
            intervals: intervals);

  factory TimeTableModel.fromJson(Map<String, dynamic> json) =>
      _$TimeTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableModelToJson(this);
}
