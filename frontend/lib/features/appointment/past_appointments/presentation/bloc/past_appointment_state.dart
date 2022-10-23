part of 'past_appointment_bloc.dart';

@immutable
abstract class PastAppointmentState extends Equatable {}

class PastAppointmentInitial extends PastAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetPastAppointmentLoadingState extends PastAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUPastAppointmentLoadedState extends PastAppointmentState {
  final List<UpcomingAppointmentResponseModel> pastResponseData;

  GetUPastAppointmentLoadedState({required this.pastResponseData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetPastAppointmentFailedState extends PastAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
