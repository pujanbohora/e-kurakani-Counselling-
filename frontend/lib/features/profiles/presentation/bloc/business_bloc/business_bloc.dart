import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/usecases/add_attachment_usecase.dart';
import 'package:frontend/features/profiles/domain/usecases/business_profile_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'business_event.dart';
part 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  var applyBusinessProfileUsecase = getIt<ApplyBusinessProfileUsecase>();

  var getBusinessProfileUsecase = getIt<GetBusinessProfileUsecase>();
  var addAttachmentUsecase = getIt<AddBusinessAttachment>();

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  var deleteBusinessAttachmentUsecase =
      getIt<DeleteBusinessAttachmentUseCase>();
  var editBusinessProfileUsecase = getIt<EditBusinessProfileUsecase>();

  BusinessBloc(this.getBusinessProfileUsecase) : super(BusinessInitial()) {
    on<BusinessEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ApplyBusinessEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(BusinessLoadingState());
        final isSuccessful =
            await applyBusinessProfileUsecase.call(event.businessProfileEntity);
        print("Success: $isSuccessful");
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(BusinessFailedState());
          } else if (l is CacheFailure) {
            emit(BusinessFailedState());
          }
        }, (r) {
          emit(BusinessLoadedState(businessProfileData: r));
          add(GetBusinessEvent(userId: userInfo!.id!));
        });
        emit(MiddleState());
      },
    );

    on<GetBusinessEvent>(
      (event, emit) async {
        emit(GetBusinessLoadingState());
        final isSuccessful = await getBusinessProfileUsecase.call(event.userId);
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetBusinessFailedState());
          } else if (l is CacheFailure) {
            emit(GetBusinessFailedState());
          }
        }, (r) {
          emit(GetBusinessLoadedState(businessProfileData: r));
        });
        // emit(MiddleState());
      },
    );

    on<AddBusinessAttachmentEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(BusinessAttachmentLoadingState());
        final isSuccessful =
            // await applyBusinessProfileUsecase.call(event.counsellorProfileEntity);
            await addAttachmentUsecase.call(event.attachmentEntity);
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(BusinessAttachmentFailedState());
          } else if (l is CacheFailure) {
            emit(BusinessAttachmentFailedState());
          }
        }, (r) {
          emit(BusinessAttachmentLoadedState(attachmentData: r));
          add(GetBusinessEvent(userId: userInfo!.id!));
        });
        emit(MiddleState());
      },
    );

    on<EditBusinessProfileEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(EditBusinessProfileLoadingState());
        final isSuccessful =
            await editBusinessProfileUsecase.call(event.businessProfileEntity);
        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(EditBusinessProfileFailedState());
          } else if (l is CacheFailure) {
            emit(EditBusinessProfileFailedState());
          }
        }, (r) {
          emit(EditBusinessProfileLoadedState(businessProfileData: r));
          add(GetBusinessEvent(userId: userInfo!.id!));
        });
        emit(MiddleState());
      },
    );

    on<DeleteBusinessAttachmentEvent>(
      (event, emit) async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        emit(BusinessAttachmentDeleteLoadingState());

        final isSuccesful =
            await deleteBusinessAttachmentUsecase.call(event.id);

        isSuccesful.fold(
          (l) => {
            if (l is ServerFailure)
              {
                emit(
                  BusinessAttachmentDeleteFailedState(),
                ),
              }
            else if (l is CacheFailure)
              {
                emit(
                  BusinessAttachmentDeleteFailedState(),
                ),
              }
          },
          (r) {
            emit(BusinessAttachmentDeletedState(data: r));
            add(GetBusinessEvent(userId: userInfo!.id!));
          },
        );
      },
    );
  }
}
