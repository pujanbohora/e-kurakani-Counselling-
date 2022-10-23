part of 'profile_request_bloc.dart';

@immutable
abstract class ProfileRequestState extends Equatable {}

class ProfileRequestInitial extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorProfileRequestLoadingState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorProfileRequestLoadedState extends ProfileRequestState {
  final CounsellorProfile counsellorProfileData;

  CounsellorProfileRequestLoadedState({required this.counsellorProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [counsellorProfileData];
}

class GetCounsellorProfileRequestLoadedState extends ProfileRequestState {
  final List<CounsellorProfile> counsellorProfileRequestsData;

  GetCounsellorProfileRequestLoadedState(
      {required this.counsellorProfileRequestsData});
  @override
  // TODO: implement props
  List<Object?> get props => [counsellorProfileRequestsData];
}

class CounsellorProfileRequestFailedState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangeBusinessProfileRequestLoadingState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetBusinessProfileRequestLoadingState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangeBusinessProfileRequestLoadedState extends ProfileRequestState {
  final BusinessProfile businessProfileData;

  ChangeBusinessProfileRequestLoadedState({required this.businessProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [businessProfileData];
}

class GetBusinessProfileRequestLoadedState extends ProfileRequestState {
  final List<BusinessProfile> businessProfileRequestsData;

  GetBusinessProfileRequestLoadedState(
      {required this.businessProfileRequestsData});
  @override
  // TODO: implement props
  List<Object?> get props => [businessProfileRequestsData];
}

class ChangeBusinessProfileRequestFailedState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetBusinessProfileRequestFailedState extends ProfileRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
