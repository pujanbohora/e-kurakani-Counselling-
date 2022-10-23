part of 'report_bloc.dart';

// import 'package:frontend/features/report/domain/entities/report_entity.dart';

@immutable
abstract class ReportEvent extends Equatable {}

class AddCounsellorReportEvent extends ReportEvent {
  final ReportEntity reportEntity;

  AddCounsellorReportEvent({required this.reportEntity});

  @override
  // TODO: implement props
  List<Object> get props => [reportEntity];
}

class AddAppointmentReportEvent extends ReportEvent {
  final ReportEntity reportEntity;

  AddAppointmentReportEvent({required this.reportEntity});

  @override
  // TODO: implement props
  List<Object> get props => [reportEntity];
}

class GetAppointmentReportEvent extends ReportEvent {
  final String type;

  GetAppointmentReportEvent({required this.type});
  // final ReportEntity reportEntity;

  // GetAppointmentReportEvent();

  @override
  // TODO: implement props
  List<Object> get props => [type];
}

class GetCounsellorReportEvent extends ReportEvent {
  final String type;
  GetCounsellorReportEvent({required this.type});
  // final ReportEntity reportEntity;

  // GetAppointmentReportEvent();

  @override
  // TODO: implement props
  List<Object> get props => [type];
}
