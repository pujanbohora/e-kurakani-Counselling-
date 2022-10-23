part of 'upcoming_appointment_bloc.dart';

@immutable
abstract class UpcomingAppointmentState extends Equatable {}

class UpcomingAppointmentInitial extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentLoadingState extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentLoadedState extends UpcomingAppointmentState {
  final List<UpcomingAppointmentResponseModel> upcomingResponseData;

  GetUpcomingAppointmentLoadedState({required this.upcomingResponseData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentFailedState extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [UpcomingAppointmentResponse];
}

class GetCustomerUpcomingAppointmentLoadingState
    extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCustomerUpcomingAppointmentLoadedState
    extends UpcomingAppointmentState {
  final List<UpcomingAppointmentResponseModel> upcomingResponseData;

  GetCustomerUpcomingAppointmentLoadedState(
      {required this.upcomingResponseData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCustomerUpcomingAppointmentFailedState
    extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [UpcomingAppointmentResponse];
}

class GetUpcomingAppointmentDetailLoadingState
    extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentDetailLoadedState extends UpcomingAppointmentState {
  final UpcomingAppointmentResponseModel upcomingResponseData;

  GetUpcomingAppointmentDetailLoadedState({required this.upcomingResponseData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentDetailFailedState extends UpcomingAppointmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [UpcomingAppointmentResponse];
}
