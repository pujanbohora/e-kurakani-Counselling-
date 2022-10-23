// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/repository/cousellor_feedback_repository.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/injectable.dart';

@injectable
class CounsellorFeedbackUsecase
    implements Usecase<CounsellorFeedbackEntities, CounsellorFeedbackEntities> {
  var counsellorFeedbackRepository = getIt<CounsellorFeedbackRepository>();

  CounsellorFeedbackUsecase(this.counsellorFeedbackRepository);

  @override
  Future<Either<Failure, CounsellorFeedbackEntities>> call(
      CounsellorFeedbackEntities data) async {
    // TODO: implement call
    return await counsellorFeedbackRepository.saveCounsellorFeedback(data);
  }
}
