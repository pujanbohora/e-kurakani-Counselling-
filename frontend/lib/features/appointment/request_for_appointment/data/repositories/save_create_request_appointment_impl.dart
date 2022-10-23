// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/data_source/save_create_request_appointment_remote_data_source.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/repository/save_request_appointment_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: CreateRequestAppointmentRepository)
class CreateRequestAppointmentRepositoryImpl
    implements CreateRequestAppointmentRepository {
  var saveCreateRequestAppointmentRemoteDataSource =
      getIt<SaveCreateRequestAppointmentRemoteDataSource>();

  CreateRequestAppointmentRepositoryImpl(
      {required this.saveCreateRequestAppointmentRemoteDataSource});

  @override
  Future<Either<Failure, CreateRequestEntiry>> saveCreateRequestAppointment(
      CreateRequestEntiry data) async {
    // TODO: implement saveCreateRequestAppointment
    try {
      final saveCreateRequestAppointmentResponse =
          await saveCreateRequestAppointmentRemoteDataSource
              .saveCreateRequestAppointment(data);

      return Right(saveCreateRequestAppointmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
