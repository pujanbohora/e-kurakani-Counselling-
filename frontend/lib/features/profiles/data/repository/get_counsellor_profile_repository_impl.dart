import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/category/data/data_source/get_category_remote_data_source.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/category/domain/repository/get_category_repository.dart';
import 'package:frontend/features/profiles/data/data_sources/get_counsellor_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCounsellorProfileRepository)
class GetCounsellorProfileRepositoryImpl
    implements GetCounsellorProfileRepository {
  var getCounsellorProfileRemotedataSource =
      getIt<GetCounsellorProfileRemotedataSource>();

  @override
  Future<Either<Failure, CounsellorProfile>> getCounsellor(userId) async {
    // TODO: implement getCategory
    try {
      final getCounsellorProfileReponse =
          await getCounsellorProfileRemotedataSource.getCounsellor(userId);

      return Right(getCounsellorProfileReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CounsellorProfile>>>
      getCounsellorProfileRequests() async {
    // TODO: implement getCategory
    try {
      final getCounsellorProfileReponse =
          await getCounsellorProfileRemotedataSource
              .getCounsellorProfileRequests();

      return Right(getCounsellorProfileReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
