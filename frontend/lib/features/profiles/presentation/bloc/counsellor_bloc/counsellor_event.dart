part of 'counsellor_bloc.dart';

@immutable
abstract class CounsellorEvent extends Equatable {}

class ApplyCounsellorEvent extends CounsellorEvent {
  final CounsellorProfile counsellorProfileEntity;

  ApplyCounsellorEvent({required this.counsellorProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [counsellorProfileEntity];
}

class GetCounsellorEvent extends CounsellorEvent {
  final String userId;

  GetCounsellorEvent({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class AddCounsellorTimeTableEvent extends CounsellorEvent {
  final CounsellorTimeTable timeTableEntity;

  AddCounsellorTimeTableEvent({required this.timeTableEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [timeTableEntity];
}

class AddCounsellorAttachmentEvent extends CounsellorEvent {
  final ProfileAttachments attachmentEntity;

  AddCounsellorAttachmentEvent({required this.attachmentEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [attachmentEntity];
}

class AddCounsellorScheduleEvent extends CounsellorEvent {
  final CounsellorTimeTable timeTableEntity;

  AddCounsellorScheduleEvent({required this.timeTableEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [timeTableEntity];
}

class EditCounsellorProfileEvent extends CounsellorEvent {
  final CounsellorProfile counsellorProfileEntity;

  EditCounsellorProfileEvent({required this.counsellorProfileEntity});

  @override
  // TODO: implement props
  List<Object> get props => [counsellorProfileEntity];
}

class DeleteCounsellorAttachmentEvent extends CounsellorEvent {
  final String id;

  DeleteCounsellorAttachmentEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
