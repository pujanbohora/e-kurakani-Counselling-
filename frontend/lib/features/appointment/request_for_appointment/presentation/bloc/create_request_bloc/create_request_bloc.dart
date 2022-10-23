// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/model/category_counsellor_response_model.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/repositories/save_create_request_appointment_impl.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/repository/save_request_appointment_repository.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/usecasess/get_counsellors_category_usecases.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/usecasess/save_request_appointment_usecase.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_page.dart';
import 'package:frontend/injectable.dart';

part 'create_request_event.dart';
part 'create_request_state.dart';

class CreateRequestBloc extends Bloc<CreateRequestEvent, CreateRequestState> {
  var saveRequestForAppointment = getIt<SaveRequestForAppointment>();
  var getCounsellorsCategoryUsecases = getIt<GetCounsellorsCategoryUsecases>();
  CreateRequestBloc(
      this.saveRequestForAppointment, this.getCounsellorsCategoryUsecases)
      : super(CreateRequestInitial()) {
    on<CreateRequestEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SaveRequestForAppointmentEvent>(
      (event, emit) async {
        emit(SaveCreateRequestAppointmentLoadingState());

        final isSuccessful =
            await saveRequestForAppointment.call(event.createRequestEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(SaveCreateRequestAppointmentFailedState());
          } else if (l is CacheFailure) {
            emit(SaveCreateRequestAppointmentFailedState());
          }
        }, (r) {
          emit(SaveCreateRequestAppointmentLoadedState());
        });
        emit(MiddleState());
      },
    );

    on<GetCounsellorsCategoryEvent>(((event, emit) async {
      emit(GetCounsellorsCategoryLoadingState());

      final isSuccessful = await getCounsellorsCategoryUsecases
          .call(GetCounsellorsCategoryParams(
        subCategoryId: event.subCategoryId,
      ));

      isSuccessful.fold((l) {
        if (l is ServerFailure) {
          emit(GetCounsellorsCategoryFailedState());
        } else if (l is CacheFailure) {
          emit(GetCounsellorsCategoryFailedState());
        }
      }, (r) {
        emit(GetCounsellorsCategoryLoadedState(categoryCounsellorResponse: r));
      });
      emit(MiddleState());
    }));
  }
}
