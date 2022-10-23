// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/add_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/repository/add_category_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: AddCategoryRepository)
class AddcategoryRepositoryImpl implements AddCategoryRepository {
  
  var addCategoryRemotedataSource = getIt<AddCategoryRemotedataSource>();

  @override
  Future<Either<Failure, AddCategoryEntity>> addCategory(
      AddCategoryEntity data) async {
    try {
      final signUpResponse =
          await addCategoryRemotedataSource.addCategory(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
