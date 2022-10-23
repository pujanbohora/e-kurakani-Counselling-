// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/repository/get_counsellors_category_repository.dart';
import 'package:frontend/injectable.dart';

@injectable
class GetCounsellorsCategoryUsecases
    implements
        Usecase<CategoryCounsellorResponse, GetCounsellorsCategoryParams> {
  var getCounsellorsCategoryRepository =
      getIt<GetCounsellorsCategoryRepository>();

  GetCounsellorsCategoryUsecases(
      {required this.getCounsellorsCategoryRepository});

  @override
  Future<Either<Failure, CategoryCounsellorResponse>> call(
      GetCounsellorsCategoryParams data) async {
    // TODO: implement call
    return await getCounsellorsCategoryRepository
        .getCounsellorsCategory(data.subCategoryId);
  }
}

class GetCounsellorsCategoryParams {
  final String subCategoryId;
  GetCounsellorsCategoryParams({required this.subCategoryId});
}

// class NoParams {}

