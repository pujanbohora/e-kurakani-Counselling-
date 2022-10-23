import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/past_appointments/domain/usecases/past_appointment_usecase.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'past_appointment_event.dart';
part 'past_appointment_state.dart';

class PastAppointmentBloc
    extends Bloc<PastAppointmentEvent, PastAppointmentState> {
  var getPastAppointmentUsecase = getIt<GetPastAppointmentUsecase>();
  PastAppointmentBloc() : super(PastAppointmentInitial()) {
    on<PastAppointmentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPastAppointmentEvent>(
      (event, emit) async {
        emit(GetPastAppointmentLoadingState());
        final isSuccessful = await getPastAppointmentUsecase.call(NoParams());

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetPastAppointmentFailedState());
          } else if (l is CacheFailure) {
            emit(GetPastAppointmentFailedState());
          }
        }, (r) {
          emit(GetUPastAppointmentLoadedState(pastResponseData: r));
        });
        // emit(MiddleState());
      },
    );
  }
}
