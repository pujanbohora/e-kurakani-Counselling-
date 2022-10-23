part of 'createcounsellor_bloc.dart';

@immutable
abstract class CreatecounsellorEvent {}

class RegisterCounsellorEvent extends CreatecounsellorEvent {
  final User user;
  RegisterCounsellorEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class GetCounsellorDetailsEvent extends CreatecounsellorEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorStatusDeleteEvent extends CreatecounsellorEvent {
  final User userdata;

  CounsellorStatusDeleteEvent({required this.userdata});
  @override
  // TODO: implement props
  List<Object?> get props => [userdata];
}
