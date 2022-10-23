// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/repository/add_category_repository.dart';
import 'package:frontend/features/category/domain/repository/get_category_repository.dart';
import 'package:frontend/injectable.dart';

@injectable
class AddcategoryUsecase
    implements Usecase<AddCategoryEntity, AddCategoryEntity> {
  var addCategoryRepository = getIt<AddCategoryRepository>();

  AddcategoryUsecase(this.addCategoryRepository);

  @override
  Future<Either<Failure, AddCategoryEntity>> call(
      AddCategoryEntity data) async {
    // TODO: implement call

    return await addCategoryRepository.addCategory(data);
  }
}

@injectable
class GetCategoryUsecase implements Usecase<List<AddCategoryEntity>, NoParams> {
  var getCategoryRepository = getIt<GetCategoryRepository>();
  @override
  Future<Either<Failure, List<AddCategoryEntity>>> call(NoParams data) async {
    // TODO: implement call

    return await getCategoryRepository.getCategory();
  }
}

@injectable
class GetSubCategoryUsecase
    implements Usecase<List<AddCategoryEntity>, NoParams> {
  var getCategoryRepository = getIt<GetCategoryRepository>();
  @override
  Future<Either<Failure, List<AddCategoryEntity>>> call(NoParams data) async {
    // TODO: implement call

    return await getCategoryRepository.getSubCategory();
  }
}
