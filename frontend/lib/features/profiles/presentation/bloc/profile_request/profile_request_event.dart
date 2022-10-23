part of 'profile_request_bloc.dart';

@immutable
abstract class ProfileRequestEvent extends Equatable {}

class ChangeCounsellorProfileRequestEvent extends ProfileRequestEvent {
  final CounsellorProfile counsellorProfileEntity;

  ChangeCounsellorProfileRequestEvent({required this.counsellorProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [counsellorProfileEntity];
}

class GetCounsellorProfileRequestEvent extends ProfileRequestEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangeBusinessProfileRequestEvent extends ProfileRequestEvent {
  final BusinessProfile businessProfileEntity;

  ChangeBusinessProfileRequestEvent({required this.businessProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [businessProfileEntity];
}

class GetBusinessProfileRequestEvent extends ProfileRequestEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
