// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/get_report_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/injectable.dart';

@injectable
class GetReportUsecase implements Usecase<List<ReportEntity>, String> {
  var getReportRepository = getIt<GetReportRepository>();

  // GetReportUsecase(this.addReportRepository);

  @override
  Future<Either<Failure, List<ReportEntity>>> call(String type) async {
    // TODO: implement call

    return await getReportRepository.getReport(type);
  }
}
