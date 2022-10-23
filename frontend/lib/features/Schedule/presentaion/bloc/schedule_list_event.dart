part of 'schedule_list_bloc.dart';

@immutable
abstract class ScheduleListEvent extends Equatable {}

// class AddCounsellorTimeTableEvent extends ScheduleListEvent {
//   final CounsellorTimeTable timeTableEntity;

//   AddCounsellorTimeTableEvent({required this.timeTableEntity});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timeTableEntity];
// }

// class AddCounsellorScheduleEvent extends ScheduleListEvent {
//   final CounsellorTimeTable timeTableEntity;

//   AddCounsellorScheduleEvent({required this.timeTableEntity});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timeTableEntity];
// }

class GetScheduleListEvent extends ScheduleListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteScheduleEvent extends ScheduleListEvent {
  final String id;

  DeleteScheduleEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
