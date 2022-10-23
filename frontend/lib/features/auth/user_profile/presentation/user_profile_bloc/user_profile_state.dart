part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileState extends Equatable {}

class UserProfileInitial extends UserProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUserProfileLoadedState extends UserProfileState {
  final User getUserData;

  GetUserProfileLoadedState({required this.getUserData});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUserProfileLoadingState extends UserProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetUserProfileFailedState extends UserProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
