import 'dart:io';

import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/add_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/category/domain/repository/add_category_repository.dart';
import 'package:frontend/features/profiles/data/data_sources/add_attachment_remote_data_source.dart';
import 'package:frontend/features/profiles/data/data_sources/apply_counsellor_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/repository/attachment_repository.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AttachmentRepository)
class AttachmentRepositoryImpl implements AttachmentRepository {
  var attachmentRemoteDataSource = getIt<AttachmentRemotedataSource>();

  @override
  Future<Either<Failure, ProfileAttachments>> addCounsellorAttachment(
      ProfileAttachments data) async {
    try {
      final attachmentResponse =
          await attachmentRemoteDataSource.addCounsellorAttachment(data);

      return Right(attachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileAttachments>> updateCounsellorAttachment(
      ProfileAttachments data) async {
    try {
      final attachmentResponse =
          await attachmentRemoteDataSource.updateCounsellorAttachment(data);

      return Right(attachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileAttachments>> addBusinessAttachment(
      ProfileAttachments data) async {
    try {
      final attachmentResponse =
          await attachmentRemoteDataSource.addBusinessAttachment(data);

      return Right(attachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
