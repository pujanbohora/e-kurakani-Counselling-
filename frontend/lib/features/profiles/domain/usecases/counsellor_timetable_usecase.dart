import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCounsellorTimeTableUsecase
    implements Usecase<Map<String, dynamic>, CounsellorTimeTable> {
  var counsellorTimeTableRepository = getIt<CounsellorProfileRepository>();

  AddCounsellorTimeTableUsecase(this.counsellorTimeTableRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      CounsellorTimeTable data) async {
    // TODO: implement call

    return await counsellorTimeTableRepository.addTimeTable(data);
  }
}

@injectable
class AddCounsellorScheduleUsecase
    implements Usecase<bool, CounsellorTimeTable> {
  var counsellorTimeTableRepository = getIt<CounsellorProfileRepository>();

  AddCounsellorScheduleUsecase(this.counsellorTimeTableRepository);

  @override
  Future<Either<Failure, bool>> call(CounsellorTimeTable data) async {
    // TODO: implement call

    return await counsellorTimeTableRepository.addSchedule(data);
  }
}
