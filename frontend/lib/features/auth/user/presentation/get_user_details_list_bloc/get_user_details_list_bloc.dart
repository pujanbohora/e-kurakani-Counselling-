import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/usecases/get_user_details_list_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'get_user_details_list_event.dart';
part 'get_user_details_list_state.dart';

class GetUserDetailsListBloc
    extends Bloc<GetUserDetailsListEvent, GetUserDetailsListState> {
  var getUserDetailsListUsecase = getIt<GetUserDetailsListUsecase>();

  GetUserDetailsListBloc() : super(GetUserDetailsListInitial()) {
    on<GetUserDetailsListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetUserDetailsEvent>(
      (event, emit) async {
        final isSuccesful = await getUserDetailsListUsecase.call(NoParams());

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(GetUserDetailsListFailedState())}
                  else if (l is CacheFailure)
                    {emit(GetUserDetailsListFailedState())}
                },
            (r) => emit(GetUserDetailsListLoadedState(userData: r)));
      },
    );
  }
}
