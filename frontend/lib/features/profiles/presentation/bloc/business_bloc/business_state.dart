part of 'business_bloc.dart';

@immutable
abstract class BusinessState extends Equatable {}

class BusinessInitial extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessLoadingState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessLoadedState extends BusinessState {
  final BusinessProfile businessProfileData;

  BusinessLoadedState({required this.businessProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [businessProfileData];
}

class BusinessFailedState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetBusinessLoadingState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetBusinessLoadedState extends BusinessState {
  final BusinessProfile businessProfileData;

  GetBusinessLoadedState({required this.businessProfileData});
  @override
  // TODO: implement props
  List<Object> get props => [businessProfileData];
}

class GetBusinessFailedState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessAttachmentLoadingState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessAttachmentLoadedState extends BusinessState {
  final ProfileAttachments attachmentData;

  BusinessAttachmentLoadedState({required this.attachmentData});
  @override
  // TODO: implement props
  List<Object?> get props => [attachmentData];
}

class BusinessAttachmentFailedState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditBusinessProfileLoadingState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditBusinessProfileLoadedState extends BusinessState {
  final BusinessProfile businessProfileData;

  EditBusinessProfileLoadedState({required this.businessProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [businessProfileData];
}

class EditBusinessProfileFailedState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessAttachmentDeletedState extends BusinessState {
  final Map<String, dynamic> data;

  BusinessAttachmentDeletedState({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class BusinessAttachmentDeleteLoadingState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessAttachmentDeleteFailedState extends BusinessState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
