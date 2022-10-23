import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/usecases/business_profile_usecase.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_profile_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'profile_request_state.dart';
part 'profile_request_event.dart';

class ProfileRequestBloc
    extends Bloc<ProfileRequestEvent, ProfileRequestState> {
  var changeStatusUsecase = getIt<ChangeCounsellorProfileStatusUsecase>();

  var getCounsellorProfileUsecase = getIt<GetCounsellorProfileUsecase>();
  var getCounsellorProfileRequestUsecase =
      getIt<GetCounsellorProfileRequestUsecase>();

  var changeBusinessStatusUsecase = getIt<ChangeBusinessProfileStatusUsecase>();

  var getBusinessProfileRequestUsecase =
      getIt<GetBusinessProfileRequestUsecase>();

  ProfileRequestBloc() : super(ProfileRequestInitial()) {
    on<ProfileRequestEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeCounsellorProfileRequestEvent>(
      (event, emit) async {
        emit(CounsellorProfileRequestLoadingState());
        final isSuccessful = await changeStatusUsecase.call(event
            .counsellorProfileEntity); // need to modify this, the use case is not this one
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorProfileRequestFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorProfileRequestFailedState());
          }
        }, (r) {
          emit(CounsellorProfileRequestLoadedState(counsellorProfileData: r));
        });
      },
    );

    on<GetCounsellorProfileRequestEvent>(
      (event, emit) async {
        emit(CounsellorProfileRequestLoadingState());
        final isSuccessful =
            await getCounsellorProfileRequestUsecase.call(NoParams());
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(CounsellorProfileRequestFailedState());
          } else if (l is CacheFailure) {
            emit(CounsellorProfileRequestFailedState());
          }
        }, (r) {
          emit(
            GetCounsellorProfileRequestLoadedState(
              counsellorProfileRequestsData: r,
            ),
          );
        });
      },
    );

    on<ChangeBusinessProfileRequestEvent>(
      (event, emit) async {
        emit(ChangeBusinessProfileRequestLoadingState());
        final isSuccessful = await changeBusinessStatusUsecase.call(event
            .businessProfileEntity); // need to modify this, the use case is not this one
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(ChangeBusinessProfileRequestFailedState());
          } else if (l is CacheFailure) {
            emit(ChangeBusinessProfileRequestFailedState());
          }
        }, (r) {
          print("inside bloc: $r");
          emit(ChangeBusinessProfileRequestLoadedState(businessProfileData: r));
        });
      },
    );

    on<GetBusinessProfileRequestEvent>(
      (event, emit) async {
        emit(GetBusinessProfileRequestLoadingState());
        final isSuccessful =
            await getBusinessProfileRequestUsecase.call(NoParams());
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetBusinessProfileRequestFailedState());
          } else if (l is CacheFailure) {
            emit(GetBusinessProfileRequestFailedState());
          }
        }, (r) {
          emit(
            GetBusinessProfileRequestLoadedState(
              businessProfileRequestsData: r,
            ),
          );
        });
      },
    );
  }
}
