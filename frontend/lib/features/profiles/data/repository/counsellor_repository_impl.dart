import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/add_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/category/domain/repository/add_category_repository.dart';
import 'package:frontend/features/profiles/data/data_sources/apply_counsellor_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CounsellorProfileRepository)
class CounsellorProfileRepositoryImpl implements CounsellorProfileRepository {
  var applyProfileRemoteDataSource =
      getIt<ApplyCounsellorProfileRemotedataSource>();

  @override
  Future<Either<Failure, CounsellorProfile>> applyVerification(
      CounsellorProfile data) async {
    try {
      final signUpResponse =
          await applyProfileRemoteDataSource.applyVerification(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CounsellorProfile>> changeStatus(
      CounsellorProfile data) async {
    try {
      final signUpResponse =
          await applyProfileRemoteDataSource.changeStatus(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addTimeTable(
      CounsellorTimeTable data) async {
    try {
      final signUpResponse =
          await applyProfileRemoteDataSource.addTimeTable(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addSchedule(CounsellorTimeTable data) async {
    try {
      final signUpResponse =
          await applyProfileRemoteDataSource.addSchedule(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CounsellorProfile>> editCounsellorProfile(
      CounsellorProfile data) async {
    try {
      final editCounsellorProfileResponse =
          await applyProfileRemoteDataSource.editCounsellorProfile(data);

      return Right(editCounsellorProfileResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteCounsellorAttachment(
      id) async {
    try {
      final deleteCounsellorAttachmentResponse =
          await applyProfileRemoteDataSource.deleteCounsellorAttachment(id);

      //local get email

      return Right(deleteCounsellorAttachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
