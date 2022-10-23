// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

abstract class GetCategoryRepository {
  Future<Either<Failure, List<AddCategoryEntity>>> getCategory();
  Future<Either<Failure, List<AddCategoryEntity>>> getSubCategory();
}
