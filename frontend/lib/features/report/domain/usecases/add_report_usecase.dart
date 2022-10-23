// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/add_report_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/injectable.dart';

@injectable
class AddReportUsecase implements Usecase<ReportEntity, ReportEntity> {
  var addReportRepository = getIt<AddReportRepository>();

  AddReportUsecase(this.addReportRepository);

  @override
  Future<Either<Failure, ReportEntity>> call(ReportEntity data) async {
    // TODO: implement call

    return await addReportRepository.addReport(data);
  }
}
