import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/data_source/get_upcoming_schedule_remote_data_source.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/repository/get_upcoming_appointment_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/exception.dart';

@Injectable(as: GetUpcomingAppointmentRespository)
class GetUpcomingAppointmentRespositoryImpl
    implements GetUpcomingAppointmentRespository {
  var getUpcomingAppointmentRemoteSource =
      getIt<GetUpcomingAppointmentRemoteSource>();
  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getUpcomingAppointment() async {
    // TODO: implement getUpcomingAppointment
    try {
      final getUpcomingAppointmentReponse =
          await getUpcomingAppointmentRemoteSource.getUpcomingAppointment();

      return Right(getUpcomingAppointmentReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>>
      getCustomerUpcomingAppointment() async {
    // TODO: implement getUpcomingAppointment
    try {
      final getUpcomingAppointmentReponse =
          await getUpcomingAppointmentRemoteSource
              .getCustomerUpcomingAppointment();

      return Right(getUpcomingAppointmentReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UpcomingAppointmentResponseModel>>
      getUpcomingAppointmentDetail(String appointmentId) async {
    // TODO: implement getUpcomingAppointment
    try {
      final getUpcomingAppointmentReponse =
          await getUpcomingAppointmentRemoteSource
              .getUpcomingAppointmentDetail(appointmentId);

      return Right(getUpcomingAppointmentReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
