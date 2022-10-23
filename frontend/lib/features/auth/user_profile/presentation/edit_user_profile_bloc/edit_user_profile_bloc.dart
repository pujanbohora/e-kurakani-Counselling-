import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';
import 'package:frontend/features/auth/user_profile/data/data_source/change_password_remote_data_source.dart';
import 'package:frontend/features/auth/user_profile/domain/usecases/change_password_useCase.dart';
import 'package:frontend/features/auth/user_profile/domain/usecases/edit_user_profile_usecases.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc
    extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  var editUserProfileUsecase = getIt<EditUserProfileUsecase>();
  var changePasswordRemoteDataSource = getIt<ChangePasswordRemoteDataSource>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  EditUserProfileBloc() : super(EditUserProfileInitial()) {
    on<EditUserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SaveUserProfileEvent>(
      (event, emit) async {
        emit(EditUserProfileLoading());

        print("inside bloc");

        final isSuccessful = await editUserProfileUsecase.call(event.user);

        print(isSuccessful);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(EditUserProfileFailed());
          } else if (l is CacheFailure) {
            emit(EditUserProfileFailed());
          }
        }, (r) {
          emit(EditUserProfileLoaded());
        });
      },
    );

    on<ChangePasswordEvent>(
      (event, emit) async {
        emit(ChangePasswordLoading());

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        // UserModel? userInfo = CachedValues.getUserInfo();

        print("i am in email bloc heppeno");

        print(userInfo);

        print("here si local databas for email bloc");

        print(userInfo!.id);

        String? id = userInfo.id;

        print("inside bloc");

        final isSuccessful = await changePasswordRemoteDataSource
            .changePassword(event.new_password, event.old_password, id!);

        print(isSuccessful);

        emit(ChangePasswordLoaded());

        // isSuccessful.fold((l) {
        //   if (l is ServerFailure) {
        //     emit(ChangePasswordFailed());
        //   } else if (l is CacheFailure) {
        //     emit(ChangePasswordFailed());
        //   }
        // }, (r) {
        //   emit(ChangePasswordLoaded());
        // });
      },
    );
  }
}
