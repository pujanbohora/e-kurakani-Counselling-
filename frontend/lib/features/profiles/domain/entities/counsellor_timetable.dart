// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class CounsellorTimeTable extends Equatable {
  final String? id;
  final String? month;
  final String? date;
  final String? start_time;
  final String? end_time;
  List<String?>? intervals;
  final CounsellorProfileModel? counsellor;

  CounsellorTimeTable({
    this.id,
    this.month,
    this.date,
    this.start_time,
    this.end_time,
    this.intervals,
    this.counsellor,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, month, date, start_time, end_time, counsellor, intervals];
}
