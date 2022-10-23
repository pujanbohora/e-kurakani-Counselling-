// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';

abstract class GetCounsellorsCategoryRepository {
  Future<Either<Failure, CategoryCounsellorResponse>> getCounsellorsCategory(
      String subCategoryId);
}
