// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/get_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/repository/get_category_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: GetCategoryRepository)
class GetcategoryRepositoryImpl implements GetCategoryRepository {
  var getCategoryRemotedataSource = getIt<GetCategoryRemotedataSource>();

  @override
  Future<Either<Failure, List<AddCategoryEntity>>> getCategory() async {
    // TODO: implement getCategory
    try {
      final getCategoryReponse =
          await getCategoryRemotedataSource.getCategory();

      return Right(getCategoryReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AddCategoryEntity>>> getSubCategory() async {
    // TODO: implement getCategory
    try {
      final getCategoryReponse =
          await getCategoryRemotedataSource.getSubCategory();

      return Right(getCategoryReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
