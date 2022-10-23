part of 'edit_user_profile_bloc.dart';

@immutable
abstract class EditUserProfileEvent extends Equatable {}

class SaveUserProfileEvent extends EditUserProfileEvent {
  final UserDetails user;

  SaveUserProfileEvent({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class ChangePasswordEvent extends EditUserProfileEvent {
  final String new_password;
  final String old_password;

  ChangePasswordEvent({required this.new_password, required this.old_password});
  @override
  // TODO: implement props
  List<Object?> get props => [new_password, old_password];
}
