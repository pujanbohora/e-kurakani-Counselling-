part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState extends Equatable {}

class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//email

class ForgetPasswordEmailVerifyLoadingState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordEmailVerifyLoadedState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordEmailVerifyFailedState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//OTP

class ForgetPasswordOTPLoadingState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordOTPLoadedState extends ForgetPasswordState {
  final String otp;

  ForgetPasswordOTPLoadedState({required this.otp});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordOTPFailedState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//password

class ForgetPasswordResetPasswordLoadingState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordResetPasswordLoadedState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ForgetPasswordResetPasswordFailedState extends ForgetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
