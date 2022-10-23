import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/profiles/data/data_sources/apply_business_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/repository/business_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BusinessProfileRepository)
class BusinessProfileRepositoryImpl implements BusinessProfileRepository {
  var applyProfileRemoteDataSource =
      getIt<ApplyBusinessProfileRemotedataSource>();

  @override
  Future<Either<Failure, BusinessProfile>> applyVerification(
      BusinessProfile data) async {
    try {
      final applyResponse =
          await applyProfileRemoteDataSource.applyVerification(data);

      return Right(applyResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BusinessProfile>> changeStatus(
      BusinessProfile data) async {
    try {
      final statusResponse =
          await applyProfileRemoteDataSource.changeStatus(data);

      return Right(statusResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BusinessProfile>> editBusinessProfile(
      BusinessProfile data) async {
    try {
      final editBusinessProfileResponse =
          await applyProfileRemoteDataSource.editBusinessProfile(data);

      return Right(editBusinessProfileResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteBusinessAttachment(
      id) async {
    try {
      final deleteBusinessAttachmentResponse =
          await applyProfileRemoteDataSource.deleteBusinessAttachment(id);

      //local get email

      return Right(deleteBusinessAttachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
