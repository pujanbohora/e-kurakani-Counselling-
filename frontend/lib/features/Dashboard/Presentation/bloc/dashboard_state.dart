part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {}

class DashboardInitial extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DashboardMiddleState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CustomerDashboardLoadingState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CustomerDashboardLoadedState extends DashboardState {
  final CustomerDashboardResponseModel customerDashboardData;

  CustomerDashboardLoadedState({required this.customerDashboardData});
  @override
  // TODO: implement props
  List<Object> get props => [customerDashboardData];
}

class CustomerDashboardFailedState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorDashboardLoadingState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CounsellorDashboardLoadedState extends DashboardState {
  final CounsellorDashboardResponseModel counsellorDashboardData;

  CounsellorDashboardLoadedState({required this.counsellorDashboardData});
  @override
  // TODO: implement props
  List<Object> get props => [counsellorDashboardData];
}

class CounsellorDashboardFailedState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessDashboardLoadingState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BusinessDashboardLoadedState extends DashboardState {
  final BusinessDashboardResponseModel businessDashboardData;

  BusinessDashboardLoadedState({required this.businessDashboardData});
  @override
  // TODO: implement props
  List<Object> get props => [businessDashboardData];
}

class BusinessDashboardFailedState extends DashboardState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
