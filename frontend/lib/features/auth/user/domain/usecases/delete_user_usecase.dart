import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/repository/delete_user_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteUserUsecase implements Usecase<Map<String, dynamic>, User> {
  var deleteUserRepository = getIt<DeleteUserRepository>();

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(User data) async {
    // TODO: implement call
    return await deleteUserRepository.deleteUser(data);
  }
}
