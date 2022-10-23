// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';

abstract class CreateRequestAppointmentRepository {
  Future<Either<Failure, CreateRequestEntiry>> saveCreateRequestAppointment(CreateRequestEntiry data);
}
