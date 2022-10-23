import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/repository/get_upcoming_appointment_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpcomingAppointmentUsecase
    implements Usecase<List<UpcomingAppointmentResponseModel>, NoParams> {
  var getUpcomingAppointmentRespository =
      getIt<GetUpcomingAppointmentRespository>();
  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>> call(
      NoParams data) async {
    // TODO: implement call

    return await getUpcomingAppointmentRespository.getUpcomingAppointment();
  }
}

@injectable
class GetCustomerUpcomingAppointmentUsecase
    implements Usecase<List<UpcomingAppointmentResponseModel>, NoParams> {
  var getUpcomingAppointmentRespository =
      getIt<GetUpcomingAppointmentRespository>();
  @override
  Future<Either<Failure, List<UpcomingAppointmentResponseModel>>> call(
      NoParams data) async {
    // TODO: implement call

    return await getUpcomingAppointmentRespository
        .getCustomerUpcomingAppointment();
  }
}

@injectable
class GetUpcomingAppointmentDetailUsecase
    implements
        Usecase<UpcomingAppointmentResponseModel,
            GetUpcomingAppointmentDetailParams> {
  var getUpcomingAppointmentRespository =
      getIt<GetUpcomingAppointmentRespository>();
  @override
  Future<Either<Failure, UpcomingAppointmentResponseModel>> call(
      GetUpcomingAppointmentDetailParams data) async {
    // TODO: implement call

    return await getUpcomingAppointmentRespository
        .getUpcomingAppointmentDetail(data.appointmentId);
  }
}

class GetUpcomingAppointmentDetailParams {
  final String appointmentId;
  GetUpcomingAppointmentDetailParams({required this.appointmentId});
}
