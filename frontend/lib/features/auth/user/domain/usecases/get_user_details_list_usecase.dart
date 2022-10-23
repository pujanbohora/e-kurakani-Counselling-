import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/repository/get_user_details_list_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDetailsListUsecase implements Usecase<List<User>, NoParams> {
  var getUserDetailsListRepository = getIt<GetUserDetailsListRepository>();
  @override
  Future<Either<Failure, List<User>>> call(NoParams) async {
    // TODO: implement call
    return await getUserDetailsListRepository.getUserDetailsList();
  }
}
