// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/repository/save_request_appointment_repository.dart';
import 'package:frontend/injectable.dart';

@injectable
class SaveRequestForAppointment
    extends Usecase<CreateRequestEntiry, CreateRequestEntiry> {
  var createRequestAppointmentRepository =
      getIt<CreateRequestAppointmentRepository>();

  SaveRequestForAppointment({required this.createRequestAppointmentRepository});

  @override
  Future<Either<Failure, CreateRequestEntiry>> call(
      CreateRequestEntiry data) async {
    // TODO: implement call
    return await createRequestAppointmentRepository
        .saveCreateRequestAppointment(data);
  }
}
