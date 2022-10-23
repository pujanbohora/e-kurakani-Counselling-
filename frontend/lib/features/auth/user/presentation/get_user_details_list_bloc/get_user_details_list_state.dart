part of 'get_user_details_list_bloc.dart';

@immutable
abstract class GetUserDetailsListState extends Equatable {}

class GetUserDetailsListInitial extends GetUserDetailsListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDetailsListLoadedState extends GetUserDetailsListState {
  final List<User> userData;

  GetUserDetailsListLoadedState({required this.userData});
  @override
  // TODO: implement props
  List<Object?> get props => [userData];
}

class GetUserDetailsListLoadingState extends GetUserDetailsListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDetailsListFailedState extends GetUserDetailsListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
