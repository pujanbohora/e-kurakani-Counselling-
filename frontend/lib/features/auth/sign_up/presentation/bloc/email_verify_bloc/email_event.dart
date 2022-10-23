part of 'email_bloc.dart';

@immutable
abstract class EmailEvent extends Equatable {}

class EmailVerificationEvent extends EmailEvent {
  final EmailVerifyCode emailVerifyCode;

  EmailVerificationEvent({required this.emailVerifyCode});

  @override
  // TODO: implement props
  List<Object> get props => [emailVerifyCode];
}
