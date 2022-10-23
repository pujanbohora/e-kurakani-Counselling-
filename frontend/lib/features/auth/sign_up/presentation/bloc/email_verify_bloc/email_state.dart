part of 'email_bloc.dart';

@immutable
abstract class EmailState extends Equatable {}

class EmailInitial extends EmailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EmailVerifyLoadingState extends EmailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EmailVerifyLoadedState extends EmailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EmailVerifyFailedState extends EmailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
