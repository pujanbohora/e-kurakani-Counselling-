part of 'create_request_bloc.dart';

@immutable
abstract class CreateRequestState extends Equatable {}

class CreateRequestInitial extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MiddleState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SaveCreateRequestAppointmentLoadingState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SaveCreateRequestAppointmentLoadedState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SaveCreateRequestAppointmentFailedState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//GetCounsellorsCategoryEvent

class GetCounsellorsCategoryLoadingState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCounsellorsCategoryLoadedState extends CreateRequestState {
  final CategoryCounsellorResponse categoryCounsellorResponse;

  GetCounsellorsCategoryLoadedState({required this.categoryCounsellorResponse});
  @override
  // TODO: implement props
  List<Object> get props => [categoryCounsellorResponse];
}

class GetCounsellorsCategoryFailedState extends CreateRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
