// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';

abstract class GetFeedbackRepository {
  Future<Either<Failure, List<CounsellorFeedbackEntities>>> getfeedback(String type);
}
