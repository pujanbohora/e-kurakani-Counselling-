part of 'schedule_list_bloc.dart';

@immutable
abstract class ScheduleListState extends Equatable {}

// class MiddleState extends ScheduleListState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

// class CounsellorTimeTableLoadingState extends ScheduleListState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

// class CounsellorTimeTableLoadedState extends ScheduleListState {
//   final Map<String, dynamic> timeTableData;

//   CounsellorTimeTableLoadedState({required this.timeTableData});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timeTableData];
// }

// class CounsellorTimeTableFailedState extends ScheduleListState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

// class CounsellorScheduleLoadingState extends ScheduleListState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

// class CounsellorScheduleLoadedState extends ScheduleListState {
//   final Map<String, dynamic> timeTableData;

//   CounsellorScheduleLoadedState({required this.timeTableData});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timeTableData];
// }

// class CounsellorScheduleFailedState extends ScheduleListState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

class ScheduleListInitial extends ScheduleListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetScheduleListLoadedState extends ScheduleListState {
  final List<ScheduleWeekEntities> scheduleWeekEntities;

  GetScheduleListLoadedState({required this.scheduleWeekEntities});
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleWeekEntities];
}

class GetScheduleListLoadingState extends ScheduleListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetScheduleListFailedState extends ScheduleListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ScheduleDeletedState extends ScheduleListState {
  final Map<String, dynamic> data;

  ScheduleDeletedState({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ScheduleDeleteLoadingState extends ScheduleListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ScheduleDeleteFailedState extends ScheduleListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
