part of 'create_request_bloc.dart';

@immutable
abstract class CreateRequestEvent extends Equatable {}

class SaveRequestForAppointmentEvent extends CreateRequestEvent {
  final CreateRequestEntiry createRequestEntity;

  SaveRequestForAppointmentEvent({required this.createRequestEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [createRequestEntity];
}

class GetCounsellorsCategoryEvent extends CreateRequestEvent {
  final String subCategoryId;

  GetCounsellorsCategoryEvent({required this.subCategoryId});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
