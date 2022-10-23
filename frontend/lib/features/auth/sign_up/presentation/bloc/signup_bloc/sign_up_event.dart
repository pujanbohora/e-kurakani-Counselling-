part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {}

class RegisterUserEvent extends SignUpEvent {
  final User user;
  RegisterUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginiWithPasswordEvent extends SignUpEvent {
  final User user;

  LoginiWithPasswordEvent({required this.user});

  @override
  List<Object> get props => [user];
}
