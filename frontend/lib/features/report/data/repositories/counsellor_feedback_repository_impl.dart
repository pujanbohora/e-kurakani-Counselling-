import 'dart:io';

import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/report/data/data_source/counsellor_feedback_remote_data_source.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/repository/cousellor_feedback_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CounsellorFeedbackRepository)
class CounsellorFeedbackRepositoryImpl implements CounsellorFeedbackRepository {
  var counsellorFeedbacRemotedataSource =
      getIt<CounsellorFeedbacRemotedataSource>();

  @override
  Future<Either<Failure, CounsellorFeedbackEntities>> saveCounsellorFeedback(
      CounsellorFeedbackEntities data) async {
    try {
      final attachmentResponse =
          await counsellorFeedbacRemotedataSource.saveCounsellorFeedback(data);

      return Right(attachmentResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
