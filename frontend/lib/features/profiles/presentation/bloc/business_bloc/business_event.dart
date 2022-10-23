part of 'business_bloc.dart';

@immutable
abstract class BusinessEvent extends Equatable {}

class ApplyBusinessEvent extends BusinessEvent {
  final BusinessProfile businessProfileEntity;

  ApplyBusinessEvent({required this.businessProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [businessProfileEntity];
}

class GetBusinessEvent extends BusinessEvent {
  final String userId;

  GetBusinessEvent({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class AddBusinessAttachmentEvent extends BusinessEvent {
  final ProfileAttachments attachmentEntity;

  AddBusinessAttachmentEvent({required this.attachmentEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [attachmentEntity];
}

class EditBusinessProfileEvent extends BusinessEvent {
  final BusinessProfile businessProfileEntity;

  EditBusinessProfileEvent({required this.businessProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [businessProfileEntity];
}

class DeleteBusinessAttachmentEvent extends BusinessEvent {
  final String id;

  DeleteBusinessAttachmentEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
