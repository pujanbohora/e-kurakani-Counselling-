// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import '../../../../core/error/errors.dart';

abstract class CounsellorFeedbackRepository {
  Future<Either<Failure, CounsellorFeedbackEntities>> saveCounsellorFeedback(
      CounsellorFeedbackEntities data);

}
