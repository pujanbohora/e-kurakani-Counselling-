// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/create_counsellor/domain/repository/create_counsellor_repository.dart';
import 'package:frontend/injectable.dart';

// ignore: unused_import
@injectable
class CreateCounsellorUsecase implements Usecase<User, User> {
  var createCounsellorRepository = getIt<CreateCounsellorRepository>();

  CreateCounsellorUsecase(this.createCounsellorRepository);

  @override
  Future<Either<Failure, User>> call(User data) async {
    // TODO: implement call
    return await createCounsellorRepository.createCounsellorRepo(data);
  }
}
