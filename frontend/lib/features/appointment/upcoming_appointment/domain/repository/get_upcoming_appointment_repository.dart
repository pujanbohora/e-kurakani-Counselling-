import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';

abstract class GetUpcomingAppointmentRespository {
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getUpcomingAppointment();
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getCustomerUpcomingAppointment();
  Future<Either<Failure, UpcomingAppointmentResponseModel>>
      getUpcomingAppointmentDetail(String appointmentId);
}
