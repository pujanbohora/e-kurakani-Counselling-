import 'dart:io';

import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/report/data/data_source/get_feedback_remote_data_source.dart';
import 'package:frontend/features/report/data/data_source/get_report_remote_data_source.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/ger_feedback_repository.dart';
import 'package:frontend/features/report/domain/repository/get_report_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetFeedbackRepository)
class GetFeedbackRepositoryImpl implements GetFeedbackRepository {
  var getFeedbackRemotedataSource = getIt<GetFeedbackRemotedataSource>();

  @override
  Future<Either<Failure, List<CounsellorFeedbackEntities>>> getfeedback(
      String type) async {
    try {
      final getReportResponse =
          await getFeedbackRemotedataSource.getfeedback(type);

      return Right(getReportResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
