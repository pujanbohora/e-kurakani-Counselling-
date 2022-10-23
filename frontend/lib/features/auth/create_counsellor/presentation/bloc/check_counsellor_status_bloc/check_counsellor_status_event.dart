part of 'check_counsellor_status_bloc.dart';

@immutable
abstract class CheckCounsellorStatusEvent extends Equatable {}

class CounsellorStatusCheckEvent extends CheckCounsellorStatusEvent {
  final User userdata;

  CounsellorStatusCheckEvent({required this.userdata});
  @override
  // TODO: implement props
  List<Object?> get props => [userdata];
}


