part of 'report_bloc.dart';

@immutable
abstract class ReportState extends Equatable {}

class ReportInitial extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ReportMiddleState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddCounsellorReportLoadingState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddAppointmentReportLoadingState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddCounsellorReportLoadedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddAppointmentReportLoadedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddCounsellorReportFailedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddAppointmentReportFailedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// get appointment

class GetAppointmentReportLoadedState extends ReportState {
  final List<ReportEntity> reportEntity;

  GetAppointmentReportLoadedState({required this.reportEntity});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAppointmentReportLoadingState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAppointmentReportFailedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//get counsellor

class GetCounsellorReportLoadedState extends ReportState {
  final List<ReportEntity> reportEntity;

  GetCounsellorReportLoadedState({required this.reportEntity});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorReportLoadingState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorReportFailedState extends ReportState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
