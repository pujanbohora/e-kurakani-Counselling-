import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';

abstract class GetPastAppointmentRespository {
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getPastAppointment();
}
