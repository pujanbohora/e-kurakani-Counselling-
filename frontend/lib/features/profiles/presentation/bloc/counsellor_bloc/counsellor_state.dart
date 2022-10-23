part of 'counsellor_bloc.dart';

@immutable
abstract class CounsellorState extends Equatable {}

class CounsellorInitial extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorLoadedState extends CounsellorState {
  final CounsellorProfile counsellorProfileData;

  CounsellorLoadedState({required this.counsellorProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [counsellorProfileData];
}

class CounsellorFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorLoadedState extends CounsellorState {
  final CounsellorProfile counsellorProfileData;

  GetCounsellorLoadedState({required this.counsellorProfileData});
  @override
  // TODO: implement props
  List<Object> get props => [counsellorProfileData];
}

class GetCounsellorFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorTimeTableLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorTimeTableLoadedState extends CounsellorState {
  final Map<String, dynamic> timeTableData;

  CounsellorTimeTableLoadedState({required this.timeTableData});
  @override
  // TODO: implement props
  List<Object?> get props => [timeTableData];
}

class CounsellorTimeTableFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorAttachmentLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorAttachmentLoadedState extends CounsellorState {
  final ProfileAttachments attachmentData;

  CounsellorAttachmentLoadedState({required this.attachmentData});
  @override
  // TODO: implement props
  List<Object?> get props => [attachmentData];
}

class CounsellorAttachmentFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorScheduleLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorScheduleLoadedState extends CounsellorState {
  final Map<String, dynamic> timeTableData;

  CounsellorScheduleLoadedState({required this.timeTableData});
  @override
  // TODO: implement props
  List<Object?> get props => [timeTableData];
}

class CounsellorScheduleFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditCounsellorProfileLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditCounsellorProfileLoadedState extends CounsellorState {
  final CounsellorProfile counsellorProfileData;

  EditCounsellorProfileLoadedState({required this.counsellorProfileData});
  @override
  // TODO: implement props
  List<Object?> get props => [counsellorProfileData];
}

class EditCounsellorProfileFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorAttachmentDeletedState extends CounsellorState {
  final Map<String, dynamic> data;

  CounsellorAttachmentDeletedState({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class CounsellorAttachmentDeleteLoadingState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorAttachmentDeleteFailedState extends CounsellorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
