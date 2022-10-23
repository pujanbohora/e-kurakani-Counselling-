import 'dart:io';

import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/report/data/data_source/get_report_remote_data_source.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/get_report_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetReportRepository)
class CounsellorFeedbackRepositoryImpl implements GetReportRepository {
  var getReportRemotedataSource = getIt<GetReportRemotedataSource>();

  @override
  Future<Either<Failure, List<ReportEntity>>> getReport(String type) async {
    try {
      final getReportResponse = await getReportRemotedataSource.getReport(type);

      return Right(getReportResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
