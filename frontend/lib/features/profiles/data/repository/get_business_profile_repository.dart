import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/features/profiles/data/data_sources/get_business_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/repository/business_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetBusinessProfileRepository)
class GetBusinessProfileRepositoryImpl implements GetBusinessProfileRepository {
  var getBusinessProfileRemotedataSource =
      getIt<GetBusinessProfileRemotedataSource>();

  @override
  Future<Either<Failure, BusinessProfile>> getBusiness(userId) async {
    // TODO: implement getCategory
    try {
      final getBusinessProfileReponse =
          await getBusinessProfileRemotedataSource.getBusiness(userId);

      return Right(getBusinessProfileReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BusinessProfile>>>
      getBusinessProfileRequests() async {
    // TODO: implement getCategory
    try {
      final getBusinessProfileReponse =
          await getBusinessProfileRemotedataSource.getBusinessProfileRequests();

      return Right(getBusinessProfileReponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
