part of 'check_user_status_bloc.dart';

@immutable
abstract class CheckUserStatusEvent extends Equatable {}

class UserStatusCheckEvent extends CheckUserStatusEvent {
  final User userdata;

  UserStatusCheckEvent({required this.userdata});
  @override
  // TODO: implement props
  List<Object?> get props => [userdata];
}

class UserStatusDeleteEvent extends CheckUserStatusEvent {
  final User userdata;

  UserStatusDeleteEvent({required this.userdata});
  @override
  // TODO: implement props
  List<Object?> get props => [userdata];
}
