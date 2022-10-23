// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/report/data/data_source/add_report_remote_data_source.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/add_report_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/add_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/repository/add_category_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: AddReportRepository)
class AddReportRepositoryImpl implements AddReportRepository {
  var addReportRemotedataSource = getIt<AddReportRemotedataSource>();

  @override
  Future<Either<Failure, ReportEntity>> addReport(ReportEntity data) async {
    try {
      final addReportResponse = await addReportRemotedataSource.addReport(data);

      return Right(addReportResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
