import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/past_appointments/domain/repository/past_appointment_repository.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/repository/get_upcoming_appointment_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPastAppointmentUsecase
    implements Usecase<List<UpcomingAppointmentResponseModel>, NoParams> {
  var getPastAppointmentRespository =
      getIt<GetPastAppointmentRespository>();
  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>> call(
      NoParams data) async {
    // TODO: implement call

    return await getPastAppointmentRespository.getPastAppointment();
  }
}


