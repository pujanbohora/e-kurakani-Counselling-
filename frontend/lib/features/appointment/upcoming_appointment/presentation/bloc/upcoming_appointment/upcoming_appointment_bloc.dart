import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/entity/upcoming_appointment_response_entity.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/usecases/get_upcoming_appointment_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'upcoming_appointment_event.dart';
part 'upcoming_appointment_state.dart';

class UpcomingAppointmentBloc
    extends Bloc<UpcomingAppointmentEvent, UpcomingAppointmentState> {
  var getUpcomingAppointmentUsecase = getIt<GetUpcomingAppointmentUsecase>();
  var getCustomerUpcomingAppointmentUsecase =
      getIt<GetCustomerUpcomingAppointmentUsecase>();
  var getUpcomingAppointmentDetailUsecase =
      getIt<GetUpcomingAppointmentDetailUsecase>();
  UpcomingAppointmentBloc() : super(UpcomingAppointmentInitial()) {
    on<UpcomingAppointmentEvent>((event, emit) {
      // TODO: implement event handler
    });

    //counsellor

    on<GetUpcomingAppointmentEvent>(
      (event, emit) async {
        emit(GetUpcomingAppointmentLoadingState());
        final isSuccessful =
            await getUpcomingAppointmentUsecase.call(NoParams());

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetUpcomingAppointmentFailedState());
          } else if (l is CacheFailure) {
            emit(GetUpcomingAppointmentFailedState());
          }
        }, (r) {
          emit(GetUpcomingAppointmentLoadedState(upcomingResponseData: r));
        });
        // emit(MiddleState());
      },
    );

    on<GetUpcomingAppointmentDetailEvent>(
      (event, emit) async {
        emit(GetUpcomingAppointmentDetailLoadingState());
        final isSuccessful = await getUpcomingAppointmentDetailUsecase
            .call(GetUpcomingAppointmentDetailParams(
          appointmentId: event.appointmentId,
        ));
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetUpcomingAppointmentDetailFailedState());
          } else if (l is CacheFailure) {
            emit(GetUpcomingAppointmentDetailFailedState());
          }
        }, (r) {
          emit(
              GetUpcomingAppointmentDetailLoadedState(upcomingResponseData: r));
        });
        // emit(MiddleState());
      },
    );
  }
}

class UpcomingCustomerAppointmentBloc
    extends Bloc<UpcomingAppointmentEvent, UpcomingAppointmentState> {
  var getUpcomingAppointmentUsecase = getIt<GetUpcomingAppointmentUsecase>();
  var getCustomerUpcomingAppointmentUsecase =
      getIt<GetCustomerUpcomingAppointmentUsecase>();
  var getUpcomingAppointmentDetailUsecase =
      getIt<GetUpcomingAppointmentDetailUsecase>();

  UpcomingCustomerAppointmentBloc() : super(UpcomingAppointmentInitial()) {
    on<UpcomingAppointmentEvent>((event, emit) {
      // TODO: implement event handler
    });

    //counsellor

    on<GetCustomerUpcomingAppointmentEvent>(
      (event, emit) async {
        emit(GetCustomerUpcomingAppointmentLoadingState());
        final isSuccessful =
            await getCustomerUpcomingAppointmentUsecase.call(NoParams());

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetCustomerUpcomingAppointmentFailedState());
          } else if (l is CacheFailure) {
            emit(GetCustomerUpcomingAppointmentFailedState());
          }
        }, (r) {
          emit(GetCustomerUpcomingAppointmentLoadedState(
              upcomingResponseData: r));
        });
        // emit(MiddleState());
      },
    );
  }
}
