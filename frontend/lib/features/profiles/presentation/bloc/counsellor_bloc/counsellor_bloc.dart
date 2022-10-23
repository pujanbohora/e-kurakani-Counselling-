import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/Schedule/presentaion/bloc/schedule_list_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/data_sources/apply_counsellor_profile_remote_data_source.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/usecases/add_attachment_usecase.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/usecases/add_attachment_usecase.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_profile_usecase.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_timetable_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'counsellor_event.dart';
part 'counsellor_state.dart';

class CounsellorBloc extends Bloc<CounsellorEvent, CounsellorState> {
  var applyProfileUsecase = getIt<ApplyCounsellorProfileUsecase>();
  var editCounsellorProfileUsecase = getIt<EditCounsellorProfileUsecase>();

  var getCounsellorProfileUsecase = getIt<GetCounsellorProfileUsecase>();
  var addCounsellorTimeTableUsecase = getIt<AddCounsellorTimeTableUsecase>();
  var addCounsellorScheduleUsecase = getIt<AddCounsellorScheduleUsecase>();
  var addAttachmentUsecase = getIt<AddAttachment>();

  var addAttachment = getIt<AddAttachment>();

  var scheduleRemoteDataSource = ApplyCounsellorProfileRemotedataSourceImpl();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  var deleteScheduleUsecase = getIt<DeleteCounsellorAttachmentUseCase>();

  CounsellorBloc(this.getCounsellorProfileUsecase)
      : super(CounsellorInitial()) {
    on<CounsellorEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ApplyCounsellorEvent>(
      (event, emit) async {
        emit(CounsellorLoadingState());
        final isSuccessful =
            await applyProfileUsecase.call(event.counsellorProfileEntity);
        print("Success: $isSuccessful");
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorFailedState());
          }
        }, (r) {
          print("inside bloc: $r");
          emit(CounsellorLoadedState(counsellorProfileData: r));
        });
        emit(MiddleState());
      },
    );

    on<GetCounsellorEvent>(
      (event, emit) async {
        emit(GetCounsellorLoadingState());
        final isSuccessful =
            await getCounsellorProfileUsecase.call(event.userId);
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetCounsellorFailedState());
          } else if (l is CacheFailure) {
            emit(GetCounsellorFailedState());
          }
        }, (r) {
          emit(GetCounsellorLoadedState(counsellorProfileData: r));
        });
        // emit(MiddleState());
      },
    );

    on<AddCounsellorTimeTableEvent>(
      (event, emit) async {
        emit(CounsellorTimeTableLoadingState());
        final isSuccessful =
            // await applyProfileUsecase.call(event.counsellorProfileEntity);
            await addCounsellorTimeTableUsecase.call(event.timeTableEntity);
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorTimeTableFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorTimeTableFailedState());
          }
        }, (r) {
          emit(CounsellorTimeTableLoadedState(timeTableData: r));
          ScheduleListBloc().add(GetScheduleListEvent());
        });
        emit(MiddleState());
      },
    );

    on<AddCounsellorAttachmentEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(CounsellorAttachmentLoadingState());
        final isSuccessful =
            // await applyProfileUsecase.call(event.counsellorProfileEntity);
            await addAttachmentUsecase.call(event.attachmentEntity);
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorAttachmentFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorAttachmentFailedState());
          }
        }, (r) {
          emit(CounsellorAttachmentLoadedState(attachmentData: r));
          add(GetCounsellorEvent(userId: userInfo!.id!));
        });
        emit(MiddleState());
      },
    );

    on<AddCounsellorScheduleEvent>(
      (event, emit) async {
        print("added event");
        emit(CounsellorScheduleLoadingState());
        final isSuccessful =
            // await applyProfileUsecase.call(event.counsellorProfileEntity);
            await addCounsellorScheduleUsecase.call(event.timeTableEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorScheduleFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorScheduleFailedState());
          }
        }, (r) {
          emit(CounsellorScheduleLoadedState(timeTableData: {"success": true}));
          ScheduleListBloc().add(GetScheduleListEvent());
        });
        emit(MiddleState());
      },
    );

    on<EditCounsellorProfileEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(EditCounsellorProfileLoadingState());
        final isSuccessful = await editCounsellorProfileUsecase
            .call(event.counsellorProfileEntity);
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(EditCounsellorProfileFailedState());
          } else if (l is CacheFailure) {
            emit(EditCounsellorProfileFailedState());
          }
        }, (r) {
          emit(EditCounsellorProfileLoadedState(counsellorProfileData: r));
          add(GetCounsellorEvent(userId: userInfo!.id!));
        });
        emit(MiddleState());
      },
    );

    on<DeleteCounsellorAttachmentEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(CounsellorAttachmentDeleteLoadingState());

        final isSuccesful = await deleteScheduleUsecase.call(event.id);

        isSuccesful.fold(
          (l) => {
            if (l is ServerFailure)
              {
                emit(
                  CounsellorAttachmentDeleteFailedState(),
                ),
              }
            else if (l is CacheFailure)
              {
                emit(
                  CounsellorAttachmentDeleteFailedState(),
                ),
              }
          },
          (r) {
            emit(CounsellorAttachmentDeletedState(data: r));
            add(GetCounsellorEvent(userId: userInfo!.id!));
          },
        );
      },
    );
  }
}
