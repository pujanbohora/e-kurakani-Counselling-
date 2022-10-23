// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/create_counsellor/data/data_sources/create_counsellor_local_data_sources.dart';
import 'package:frontend/features/auth/create_counsellor/data/data_sources/create_cousellor_remote_data_source.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/create_counsellor/domain/repository/create_counsellor_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: CreateCounsellorRepository)
class CreateCounsellorRepositoryImpl implements CreateCounsellorRepository {
  var createCounsellorRemoteDataSource =
      getIt<CreateCounsellorRemoteDataSource>();

  CreateCounsellorRepositoryImpl({
    required this.createCounsellorRemoteDataSource,
    // required this.signUpLocalDataSource
  });

  @override
  Future<Either<Failure, UserModel>> createCounsellorRepo(User data) async {
    try {
      final signUpResponse =
          await createCounsellorRemoteDataSource.createCounsellor(data);

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, User>> loginWithPassword(User data) async {
  //   print("loginWithPassword Repository");
  //   // TODO: implement loginWithPassword
  //   try {
  //     final signUpResponse =
  //         await createCounsellorRemoteDataSource.loginWithPassword(data);

  //     await createCounsellorLocalDataSource
  //         .saveCredentialsDataToLocal(signUpResponse);

  //     print(signUpResponse.user!);

  //     return Right(signUpResponse.user!);
  //   } on CacheException {
  //     return Left(CacheFailure());
  //   } catch (e) {
  //     print("object1233444444");
  //     return Left(ServerFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, User>> createCounsellorRepo(User data) {
  //   // TODO: implement createCounsellorRepo
  //   throw UnimplementedError();
  // }
}
