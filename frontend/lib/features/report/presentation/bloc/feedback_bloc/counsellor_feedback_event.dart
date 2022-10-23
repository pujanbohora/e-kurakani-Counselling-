part of 'counsellor_feedback_bloc.dart';

@immutable
abstract class CounsellorFeedbackEvent extends Equatable {}

class SaveCounsellorFeedbackEvent extends CounsellorFeedbackEvent {
  final CounsellorFeedbackEntities counsellorData;

  SaveCounsellorFeedbackEvent({required this.counsellorData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetFeedbackAppointmentEvent extends CounsellorFeedbackEvent {
  final String type;
  GetFeedbackAppointmentEvent({required this.type});
  // final ReportEntity reportEntity;

  // GetAppointmentReportEvent();

  @override
  // TODO: implement props
  List<Object> get props => [type];
}

// class GetAppointmentFeedbackEvent extends CounsellorFeedbackEvent {
//   final String type;
//   GetAppointmentFeedbackEvent({required this.type});
//   // final ReportEntity reportEntity;

//   // GetAppointmentReportEvent();

//   @override
//   // TODO: implement props
//   List<Object> get props => [type];
// }
