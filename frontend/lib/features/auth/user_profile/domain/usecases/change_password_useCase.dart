// import 'package:frontend/core/error/errors.dart';
// import 'package:dartz/dartz.dart';
// import 'package:frontend/core/use_cases/use_cases.dart';
// import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
// import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';
// import 'package:frontend/features/auth/user_profile/domain/repository/change_password_repository.dart';
// import 'package:frontend/features/auth/user_profile/domain/repository/edit_user_profile_repository.dart';
// import 'package:frontend/injectable.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class ChangePasswordUsecase implements Usecase<UserDetails, User> {
//   var changePasswordRepository = getIt<ChangePasswordRepository>();
//   @override
//   Future<Either<Failure, UserDetails>> call(User userData) async {
//     print("usecase");
//     // TODO: implement call
//     return await changePasswordRepository.changePassword(userData);
//   }
// }
