import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/forgot_password/domain/usecases/forget_password_email_verify_usecase.dart';
import 'package:frontend/features/auth/forgot_password/domain/usecases/forget_password_otp_usecase.dart';
import 'package:frontend/features/auth/forgot_password/domain/usecases/forget_password_reset_password_usecase.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  var forgetPasswordEmailVerification =
      getIt<ForgetPasswordEmailVerification>();
  var forgetPasswordOTPVerifyUsecase = getIt<ForgetPasswordOTPVerifyUsecase>();
  var forgetPasswordResetPasswordUsecase =
      getIt<ForgetPasswordResetPasswordUsecase>();
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    //email

    on<ForgetPasswordEmailVerifyEvent>(
      (event, emit) async {
        emit(ForgetPasswordEmailVerifyLoadingState());

        await signUpLocalDataSource.saveUserDataToLocal(event.userModel);

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        final isSuccesful = await forgetPasswordEmailVerification
            .call(UserModel(email: event.userModel.email));

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(ForgetPasswordEmailVerifyFailedState())}
                  else if (l is CacheFailure)
                    {emit(ForgetPasswordEmailVerifyFailedState())}
                },
            (r) => emit(ForgetPasswordEmailVerifyLoadedState()));

        emit(MiddleState());
      },
    );

    //otp

    on<ForgetPasswordOTPEvent>(
      (event, emit) async {
        emit(ForgetPasswordOTPLoadingState());

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        String? email = userInfo!.email;

        final isSuccesful = await forgetPasswordOTPVerifyUsecase.call(
            EmailVerifyCode(email: email, otp: event.emailVerifyCode.otp));

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(ForgetPasswordOTPFailedState())}
                  else if (l is CacheFailure)
                    {emit(ForgetPasswordOTPFailedState())}
                }, (r) {
          emit(ForgetPasswordOTPLoadedState(otp: r));
        });

        emit(MiddleState());
      },
    );

    //password

    on<ForgetPasswordResetPasswordEvent>(
      (event, emit) async {
        emit(ForgetPasswordResetPasswordLoadingState());

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        String? email = userInfo!.email;

        final isSuccesful = await forgetPasswordResetPasswordUsecase.call(User(
            email: email, password: event.user.password, otp: event.user.otp));

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(ForgetPasswordResetPasswordFailedState())}
                  else if (l is CacheFailure)
                    {emit(ForgetPasswordResetPasswordFailedState())}
                },
            (r) => emit(ForgetPasswordResetPasswordLoadedState()));

        emit(MiddleState());
      },
    );
  }
}
