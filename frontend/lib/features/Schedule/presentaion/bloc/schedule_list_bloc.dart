import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:frontend/features/Schedule/domain/usecases/schedule_list_usecase.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_timetable_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'schedule_list_event.dart';
part 'schedule_list_state.dart';

class ScheduleListBloc extends Bloc<ScheduleListEvent, ScheduleListState> {
  var getScheduleListUsecase = getIt<GetScheduleListUsecase>();
  var deleteScheduleUsecase = getIt<DeleteScheduleUseCase>();
  var addCounsellorTimeTableUsecase = getIt<AddCounsellorTimeTableUsecase>();
  var addCounsellorScheduleUsecase = getIt<AddCounsellorScheduleUsecase>();
  ScheduleListBloc() : super(ScheduleListInitial()) {
    on<ScheduleListEvent>((event, emit) {
      // TODO: implement event handler
    });

    // on<AddCounsellorTimeTableEvent>(
    //   (event, emit) async {
    //     emit(CounsellorTimeTableLoadingState());
    //     final isSuccessful =
    //         // await applyProfileUsecase.call(event.counsellorProfileEntity);
    //         await addCounsellorTimeTableUsecase.call(event.timeTableEntity);
    //     isSuccessful.fold((l) {
    //       if (l is ServerFailure) {
    //         emit(CounsellorTimeTableFailedState());
    //       } else if (l is CacheFailure) {
    //         emit(CounsellorTimeTableFailedState());
    //       }
    //     }, (r) {
    //       emit(CounsellorTimeTableLoadedState(timeTableData: r));
    //       add(GetScheduleListEvent());
    //     });
    //     emit(MiddleState());
    //   },
    // );

    // on<AddCounsellorScheduleEvent>(
    //   (event, emit) async {
    //     print("added event");
    //     emit(CounsellorScheduleLoadingState());
    //     final isSuccessful =
    //         // await applyProfileUsecase.call(event.counsellorProfileEntity);
    //         await addCounsellorScheduleUsecase.call(event.timeTableEntity);

    //     isSuccessful.fold((l) {
    //       if (l is ServerFailure) {
    //         emit(CounsellorScheduleFailedState());
    //       } else if (l is CacheFailure) {
    //         emit(CounsellorScheduleFailedState());
    //       }
    //     }, (r) {
    //       emit(CounsellorScheduleLoadedState(timeTableData: {"success": true}));
    //       add(GetScheduleListEvent());
    //     });
    //     emit(MiddleState());
    //   },
    // );

    on<GetScheduleListEvent>(
      (event, emit) async {
        emit(GetScheduleListLoadingState());

        final isSuccesful = await getScheduleListUsecase.call(NoParams());

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(GetScheduleListFailedState())}
                  else if (l is CacheFailure)
                    {emit(GetScheduleListFailedState())}
                },
            (r) => emit(GetScheduleListLoadedState(scheduleWeekEntities: r)));
      },
    );

    on<DeleteScheduleEvent>(
      (event, emit) async {
        emit(ScheduleDeleteLoadingState());

        final isSuccesful = await deleteScheduleUsecase.call(event.id);

        isSuccesful.fold(
          (l) => {
            if (l is ServerFailure)
              {
                emit(
                  ScheduleDeleteFailedState(),
                ),
              }
            else if (l is CacheFailure)
              {
                emit(
                  ScheduleDeleteFailedState(),
                ),
              }
          },
          (r) {
            emit(ScheduleDeletedState(data: r));
            add(GetScheduleListEvent());
          },
        );
      },
    );
  }
}
