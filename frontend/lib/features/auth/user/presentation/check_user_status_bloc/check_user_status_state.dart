part of 'check_user_status_bloc.dart';

@immutable
abstract class CheckUserStatusState extends Equatable {}

class CheckUserStatusInitial extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckUserStatusLoaded extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckUserStatusLoading extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckUserStatusFailed extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//delete

class DeletUserLoaded extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteUserLoading extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteUserFailed extends CheckUserStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
