import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/usecases/counsellor_feedback_usecases.dart';
import 'package:frontend/features/report/domain/usecases/get_feedback_useCase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'counsellor_feedback_event.dart';
part 'counsellor_feedback_state.dart';

class CounsellorFeedbackBloc
    extends Bloc<CounsellorFeedbackEvent, CounsellorFeedbackState> {
  var counsellorFeedbackUsecase = getIt<CounsellorFeedbackUsecase>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  var getFeedbackUsecase = getIt<GetFeedbackUsecase>();

  CounsellorFeedbackBloc() : super(CounsellorFeedbackInitial()) {
    on<CounsellorFeedbackEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SaveCounsellorFeedbackEvent>((event, emit) async {
      emit(CounsellorFeedbackLoadingState());

      print("hello hello hello");

      UserModel? userInfo = await signUpLocalDataSource.getUserDataFromLocal();

      // UserModel? userInfo = CachedValues.getUserInfo();
      print("i am in email bloc heppeno");

      print(userInfo);

      print("here si local databas for email bloc");

      print(userInfo!.id);

      String? id = userInfo.id;

      final isSuccesful = await counsellorFeedbackUsecase.call(
        CounsellorFeedbackEntities(
            feedback_by: UserModel(id: id),
            counsellor: event.counsellorData.counsellor,
            feedback_for: event.counsellorData.feedback_for,
            star: event.counsellorData.star,
            message: event.counsellorData.message),
      );

      isSuccesful.fold(
          (l) => {
                if (l is ServerFailure)
                  {emit(CounsellorFeedbackFailedState())}
                else if (l is CacheFailure)
                  {emit(CounsellorFeedbackFailedState())}
              },
          (r) => emit(CounsellorFeedbackLoadedState()));
    });

    on<GetFeedbackAppointmentEvent>(
      (event, emit) async {
        emit(GetFeedbackLoadingState());

        print("this is this feedback happeno");

        final isSuccessful = await getFeedbackUsecase.call(event.type);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetFeedbackFailedState());
          } else if (l is CacheFailure) {
            emit(GetFeedbackFailedState());
          }
        }, (r) {
          emit(GetFeedbackLoadedState(reportEntity: r));
        });
        // emit(CategorMiddleState());
      },
    );

    // on<GetFeedbackEvent>(
    //   (event, emit) async {
    //     emit(GetFeedbackLoadingState());

    //     final isSuccessful = await getFeedbackUsecase.call(event.type);

    //     isSuccessful.fold((l) {
    //       if (l is ServerFailure) {
    //         emit(GetFeedbackFailedState());
    //       } else if (l is CacheFailure) {
    //         emit(GetFeedbackFailedState());
    //       }
    //     }, (r) {
    //       emit(GetFeedbackLoadedState(reportEntity: r));
    //     });
    //     // emit(CategorMiddleState());
    //   },
    // );
  }
}
