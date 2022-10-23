part of 'counsellor_feedback_bloc.dart';

@immutable
abstract class CounsellorFeedbackState extends Equatable {}

class CounsellorFeedbackInitial extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorFeedbackLoadedState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorFeedbackLoadingState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorFeedbackFailedState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//get
class GetFeedbackLoadedState extends CounsellorFeedbackState {
  final List<CounsellorFeedbackEntities> reportEntity;

  GetFeedbackLoadedState({required this.reportEntity});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetFeedbackLoadingState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetFeedbackFailedState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//get appointment

class GetFeedbackAppointmentLoadedState extends CounsellorFeedbackState {
  final List<CounsellorFeedbackEntities> reportEntity;

  GetFeedbackAppointmentLoadedState({required this.reportEntity});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetFeedbackAppointmentLoadingState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetFeedbackAppointmentFailedState extends CounsellorFeedbackState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
