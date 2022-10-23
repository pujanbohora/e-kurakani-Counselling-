part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {}
class SignUpInitial extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignUpMiddleState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//signup

class SignupLoadingState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignupLoadedState extends SignUpState {
  final User user;
  SignupLoadedState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignupFailedState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//Login

class LoginWithPasswordLoadingState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithPasswordLoadedState extends SignUpState {
  final String message;
  LoginWithPasswordLoadedState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class LoginWithPasswordFailedState extends SignUpState {
  final String? message;
  LoginWithPasswordFailedState({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

//customer
class LoginWithPasswordUserVerfiyedCustomerState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//business user
class LoginWithPasswordUserVerfiyedBusinessState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//counsellor
class LoginWithPasswordUserVerfiyedCounsellorState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//admin
class LoginWithPasswordUserVerfiyedAdminState extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithPasswordUserNotVerfiyedState extends SignUpState {
  final String message;
  LoginWithPasswordUserNotVerfiyedState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
