// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import '../../../../core/error/errors.dart';

abstract class CounsellorProfileRepository {
  Future<Either<Failure, CounsellorProfile>> applyVerification(
      CounsellorProfile data);
  Future<Either<Failure, CounsellorProfile>> changeStatus(
      CounsellorProfile data);
  Future<Either<Failure, Map<String, dynamic>>> addTimeTable(
      CounsellorTimeTable data);
  Future<Either<Failure, bool>> addSchedule(CounsellorTimeTable data);
  Future<Either<Failure, CounsellorProfile>> editCounsellorProfile(
      CounsellorProfile data);
  Future<Either<Failure, Map<String, dynamic>>> deleteCounsellorAttachment(id);
}

abstract class GetCounsellorProfileRepository {
  Future<Either<Failure, CounsellorProfile>> getCounsellor(String userId);
  Future<Either<Failure, List<CounsellorProfile>>>
      getCounsellorProfileRequests();
}
