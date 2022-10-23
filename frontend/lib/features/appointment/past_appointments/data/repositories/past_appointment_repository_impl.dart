import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/appointment/past_appointments/data/data_source/past_appointment_remote_data_source.dart';
import 'package:frontend/features/appointment/past_appointments/domain/repository/past_appointment_repository.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/exception.dart';

@Injectable(as: GetPastAppointmentRespository)
class GetPastAppointmentRespositoryImpl
    implements GetPastAppointmentRespository {
  var getPastAppointmentRemoteSource = getIt<GetPastAppointmentRemoteSource>();
  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getPastAppointment() async {
    // TODO: implement getUpcomingAppointment
    try {
      final getUpcomingAppointmentReponse =
          await getPastAppointmentRemoteSource.getPastAppointment();

      return Right(getUpcomingAppointmentReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
