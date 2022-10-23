// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/login_with_pasword.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/sign_up_register_user.dart';
import 'package:frontend/injectable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  var signUpRepositorUser = getIt<SignUpRegisterUser>();

  var loginWithPasswordUsecase = getIt<LoginWithPassword>();

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  var preference = getIt<SharedPreferences>();

  SignUpBloc(
      this.loginWithPasswordUsecase, this.signUpRepositorUser, this.preference)
      : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});

    on<RegisterUserEvent>((event, emit) async {
      emit(SignupLoadingState());

      final isSuccessful = await signUpRepositorUser.call(event.user);

      isSuccessful.fold((l) {
        if (l is ServerFailure) {
          emit(SignupFailedState());
        } else if (l is CacheFailure) {
          emit(SignupFailedState());
        }
      }, (r) {
        emit(SignupLoadedState(user: r));
      });
      emit(SignUpMiddleState());
    });

    on<LoginiWithPasswordEvent>(
      (event, emit) async {
        emit(LoginWithPasswordLoadingState());

        final isSuccessful = await loginWithPasswordUsecase.call(event.user);

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(LoginWithPasswordFailedState());
          } else if (l is CacheFailure) {
            emit(LoginWithPasswordFailedState());
          }
        }, (r) async {
          if (userInfo!.is_suspended == false && userInfo.is_active == true) {
            if (userInfo.user_role == 'Counsellor') {
              emit(LoginWithPasswordUserVerfiyedCounsellorState());
            } else if (userInfo.user_role == 'Business') {
              emit(LoginWithPasswordUserVerfiyedBusinessState());
            } else if (userInfo.user_role == 'Customer') {
              emit(LoginWithPasswordUserVerfiyedCustomerState());
            } else if (userInfo.user_role == 'Admin') {
              emit(LoginWithPasswordUserVerfiyedAdminState());
            }
          } else if (userInfo.is_active == false) {
            emit(LoginWithPasswordUserNotVerfiyedState(
                message: "Your account has not been verifyed!"));
          }
          // else if (keys["is_suspended"] == false) {
          //   emit(LoginWithPasswordFailedState(
          //       message: "Your account has been suspended!"));
          // }
        });
        emit(SignUpMiddleState());
      },
    );
  }
}
