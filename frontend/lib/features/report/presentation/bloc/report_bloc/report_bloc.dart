// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/domain/usecases/add_report_usecase.dart';
import 'package:frontend/features/report/domain/usecases/get_report_useCase.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/injectable.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  var addReportUsecase = getIt<AddReportUsecase>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  var getReportUsecase = getIt<GetReportUsecase>();

  ReportBloc() : super(ReportInitial()) {
    on<ReportEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddAppointmentReportEvent>(
      (event, emit) async {
        emit(AddAppointmentReportLoadingState());

        final isSuccessful = await addReportUsecase.call(event.reportEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(AddAppointmentReportFailedState());
          } else if (l is CacheFailure) {
            emit(AddAppointmentReportFailedState());
          }
        }, (r) {
          emit(AddAppointmentReportLoadedState());
        });
        // emit(CategorMiddleState());
      },
    );

    on<AddCounsellorReportEvent>(
      (event, emit) async {
        emit(AddCounsellorReportLoadingState());

        print("hello hello hello");

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        // UserModel? userInfo = CachedValues.getUserInfo();
        print("i am in email bloc heppeno");

        print(userInfo);

        print("here si local databas for email bloc");

        print(userInfo!.id);
        print("bloc");

        String? id = userInfo.id;
        final isSuccessful = await addReportUsecase.call(ReportEntity(
          counsellor: event.reportEntity.counsellor,
          report_for: event.reportEntity.report_for,
          reported_by: UserModel(id: id),
          title: event.reportEntity.title,
          description: event.reportEntity.description,
        ));

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(AddCounsellorReportFailedState());
          } else if (l is CacheFailure) {
            emit(AddCounsellorReportFailedState());
          }
        }, (r) {
          emit(AddCounsellorReportLoadedState());
        });
        // emit(CategorMiddleState());
      },
    );

    on<GetAppointmentReportEvent>(
      (event, emit) async {
        emit(GetAppointmentReportLoadingState());

        final isSuccessful = await getReportUsecase.call(event.type);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetAppointmentReportFailedState());
          } else if (l is CacheFailure) {
            emit(GetAppointmentReportFailedState());
          }
        }, (r) {
          emit(GetAppointmentReportLoadedState(reportEntity: r));
        });
        // emit(CategorMiddleState());
      },
    );

    on<GetCounsellorReportEvent>(
      (event, emit) async {
        emit(GetCounsellorReportLoadingState());

        final isSuccessful = await getReportUsecase.call(event.type);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetCounsellorReportFailedState());
          } else if (l is CacheFailure) {
            emit(GetCounsellorReportFailedState());
          }
        }, (r) {
          emit(GetCounsellorReportLoadedState(reportEntity: r));
        });
        // emit(CategorMiddleState());
      },
    );
  }
}
