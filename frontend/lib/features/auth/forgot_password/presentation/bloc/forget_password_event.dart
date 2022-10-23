part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent extends Equatable {}

//email

class ForgetPasswordEmailVerifyEvent extends ForgetPasswordEvent {
  final UserModel userModel;

  ForgetPasswordEmailVerifyEvent({required this.userModel});

  @override
  // TODO: implement props
  List<Object> get props => [UserModel];
}

//otp

class ForgetPasswordOTPEvent extends ForgetPasswordEvent {
  final EmailVerifyCode emailVerifyCode;

  ForgetPasswordOTPEvent({required this.emailVerifyCode});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [emailVerifyCode];
}

//password

class ForgetPasswordResetPasswordEvent extends ForgetPasswordEvent {
  final User user;

  ForgetPasswordResetPasswordEvent({required this.user});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [user];
}
