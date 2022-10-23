// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:frontend/injectable.dart';

@Injectable(as: SignUpRepository)
class SignUpRepositoryImpl implements SignUpRepository {
  var signUpRemoteDataSource = getIt<SignUpRemoteDataSource>();

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  SignUpRepositoryImpl({
    required this.signUpRemoteDataSource,
    // required this.signUpLocalDataSource
  });

  @override
  Future<Either<Failure, UserModel>> registerUser(User data) async {
    try {
      final signUpResponse = await signUpRemoteDataSource.registerUser(data);

      signUpLocalDataSource.saveUserDataToLocal(signUpResponse);

      // print(signUpLocalDataSource.saveUserDataToLocal(signUpResponse));

      return Right(signUpResponse);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(User data) async {
    // TODO: implement loginWithPassword
    try {
      final signUpResponse =
          await signUpRemoteDataSource.loginWithPassword(data);

      await signUpLocalDataSource.saveCredentialsDataToLocal(signUpResponse);

      return Right(signUpResponse.user!);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
