part of 'createcounsellor_bloc.dart';

@immutable
abstract class CreatecounsellorState {}

class CreatecounsellorInitial extends CreatecounsellorState {}

//create associated counsellor account
class CreateCounsellorLoading extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateCounsellorLoadedState extends CreatecounsellorState {
  final User user;
  CreateCounsellorLoadedState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateCounsellorFailedState extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorDetailsListInitial extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorDetailsListLoadedState extends CreatecounsellorState {
  final List<User> userData;

  GetCounsellorDetailsListLoadedState({required this.userData});
  @override
  // TODO: implement props
  List<Object?> get props => [userData];
}

class GetCounsellorDetailsListLoadingState extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorDetailsListFailedState extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeletCounsellorLoaded extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCounsellorLoading extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCounsellorFailed extends CreatecounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
