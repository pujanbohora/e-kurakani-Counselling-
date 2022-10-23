// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';

abstract class GetReportRepository {
  Future<Either<Failure, List<ReportEntity>>> getReport(String type);
}
