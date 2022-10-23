// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/repository/ger_feedback_repository.dart';
import 'package:frontend/features/report/domain/repository/get_report_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/injectable.dart';

@injectable
class GetFeedbackUsecase implements Usecase<List<CounsellorFeedbackEntities>, String> {
  var getFeedbackRepository = getIt<GetFeedbackRepository>();

  // GetReportUsecase(this.addReportRepository);

  @override
  Future<Either<Failure, List<CounsellorFeedbackEntities>>> call(String type) async {
    // TODO: implement call

    return await getFeedbackRepository.getfeedback(type);
  }
}
