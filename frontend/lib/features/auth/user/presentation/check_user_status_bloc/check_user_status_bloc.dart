import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/usecases/check_user_status_usecase.dart';
import 'package:frontend/features/auth/user/domain/usecases/delete_user_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'check_user_status_event.dart';
part 'check_user_status_state.dart';

class CheckUserStatusBloc
    extends Bloc<CheckUserStatusEvent, CheckUserStatusState> {
  var checkUserStatusUsecase = getIt<CheckUserStatusUsecase>();
  var deleteUserUsecase = getIt<DeleteUserUsecase>();
  CheckUserStatusBloc() : super(CheckUserStatusInitial()) {
    on<CheckUserStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UserStatusCheckEvent>(
      (event, emit) async {
        emit(CheckUserStatusLoading());
        final isSuccesful = await checkUserStatusUsecase.call(event.userdata);

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(CheckUserStatusFailed())}
                  else if (l is CacheFailure)
                    {emit(CheckUserStatusFailed())}
                },
            (r) => emit(CheckUserStatusLoaded()));

        emit(MiddleState());
      },
    );

    on<UserStatusDeleteEvent>(
      (event, emit) async {
        emit(DeleteUserLoading());
        final isSuccesful = await deleteUserUsecase.call(event.userdata);

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(DeleteUserFailed())}
                  else if (l is CacheFailure)
                    {emit(DeleteUserFailed())}
                },
            (r) => emit(DeletUserLoaded()));
        emit(MiddleState());
      },
    );
  }
}
