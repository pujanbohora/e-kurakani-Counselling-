import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/createcounsellor_bloc.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/usecases/check_user_status_usecase.dart';
import 'package:frontend/features/auth/user/domain/usecases/delete_user_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'check_counsellor_status_event.dart';
part 'check_counsellor_status_state.dart';

class CheckCounsellorStatusBloc
    extends Bloc<CheckCounsellorStatusEvent, CheckCounsellorStatusState> {
  var checkCounsellorStatusUsecase = getIt<CheckUserStatusUsecase>();

  CheckCounsellorStatusBloc() : super(CheckCounsellorStatusInitial()) {
    on<CheckCounsellorStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CounsellorStatusCheckEvent>(
      (event, emit) async {
        emit(CheckCounsellorStatusLoading());

        final isSuccesful =
            await checkCounsellorStatusUsecase.call(event.userdata);

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(CheckCounsellorStatusFailed())}
                  else if (l is CacheFailure)
                    {emit(CheckCounsellorStatusFailed())}
                },
            (r) => emit(CheckCounsellorStatusLoaded()));

        emit(MiddleState());
      },
    );
  }
}
