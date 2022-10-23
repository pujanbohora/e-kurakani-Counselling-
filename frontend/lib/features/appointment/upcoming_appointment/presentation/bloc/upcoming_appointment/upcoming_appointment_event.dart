part of 'upcoming_appointment_bloc.dart';

@immutable
abstract class UpcomingAppointmentEvent extends Equatable {}

class GetUpcomingAppointmentEvent extends UpcomingAppointmentEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCustomerUpcomingAppointmentEvent extends UpcomingAppointmentEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUpcomingAppointmentDetailEvent extends UpcomingAppointmentEvent {
  final String appointmentId;

  GetUpcomingAppointmentDetailEvent({required this.appointmentId});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
