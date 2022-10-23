// class GetCounsellorsCategoryRepositoryImpl implement GetCounsellorsCategoryRepository

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/data_source/get_counsellors_category_remote_data_source.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/repository/get_counsellors_category_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: GetCounsellorsCategoryRepository)
class GetCounsellorsCategoryRepositoryImpl
    implements GetCounsellorsCategoryRepository {
  var getCounsellorsCategoryRemoteDataSource =
      getIt<GetCounsellorsCategoryRemoteDataSource>();

  @override
  Future<Either<Failure, CategoryCounsellorResponse>> getCounsellorsCategory(
      String subCategoryId) async {
    try {
      print("GetCounsellorsCategoryRepositoryImpl");
      final getCounsellorsCategoryReponse =
          await getCounsellorsCategoryRemoteDataSource
              .getCounsellorsCategory(subCategoryId);

              print(getCounsellorsCategoryReponse);

      return Right(getCounsellorsCategoryReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
