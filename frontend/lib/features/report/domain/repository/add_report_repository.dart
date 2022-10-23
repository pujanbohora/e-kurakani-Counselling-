// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';

abstract class AddReportRepository {
  Future<Either<Failure, ReportEntity>> addReport(
    ReportEntity data,
  );
}
