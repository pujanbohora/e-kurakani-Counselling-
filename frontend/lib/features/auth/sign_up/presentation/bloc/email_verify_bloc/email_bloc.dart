// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/email_verification_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  var emailVerification = getIt<EmailVerification>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  var preference = getIt<SharedPreferences>();

  EmailBloc(this.emailVerification) : super(EmailInitial()) {
    on<EmailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<EmailVerificationEvent>(
      (event, emit) async {
        emit(EmailVerifyLoadingState());

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        // UserModel? userInfo = CachedValues.getUserInfo();

        String? email = userInfo!.email;

        final isSuccesful = await emailVerification.call(
            EmailVerifyCode(email: email, otp: event.emailVerifyCode.otp));

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(EmailVerifyFailedState())}
                  else if (l is CacheFailure)
                    {emit(EmailVerifyFailedState())}
                },
            (r) => emit(EmailVerifyLoadedState()));
      },
    );
  }
}
