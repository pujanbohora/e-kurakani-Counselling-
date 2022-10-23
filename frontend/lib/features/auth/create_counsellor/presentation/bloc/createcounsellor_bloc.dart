// Package imports:
import 'package:bloc/bloc.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/auth/create_counsellor/domain/usecases/create_cousellor_usecase.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/domain/usecases/delete_user_usecase.dart';
import 'package:frontend/features/auth/user/domain/usecases/get_user_details_list_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

part 'createcounsellor_event.dart';
part 'createcounsellor_state.dart';

class CreatecounsellorBloc
    extends Bloc<CreatecounsellorEvent, CreatecounsellorState> {
  var preference = getIt<SharedPreferences>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  var createCounsellorUsecase = getIt<CreateCounsellorUsecase>();
  var getUserDetailsListUsecase = getIt<GetUserDetailsListUsecase>();
  var deleteCounsellorUsecase = getIt<DeleteUserUsecase>();
  CreatecounsellorBloc() : super(CreatecounsellorInitial()) {
    on<CreatecounsellorEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegisterCounsellorEvent>(((event, emit) async {
      // String? email = event.user.email;
      UserModel? userInfo = await signUpLocalDataSource.getUserDataFromLocal();
      String? email = userInfo!.email;
      final isSuccessful = await createCounsellorUsecase.call(User(
          email: event.user.email,
          user_role: event.user.user_role,
          associated_business: email,
          password: event.user.password));
      isSuccessful.fold((l) {
        if (l is ServerFailure) {
          emit(CreateCounsellorFailedState());
        } else if (l is CacheFailure) {
          emit(CreateCounsellorFailedState());
        }
      }, (r) {
        emit(CreateCounsellorLoadedState(user: r));
      });
    }));

    on<GetCounsellorDetailsEvent>(
      (event, emit) async {
        final isSuccesful = await getUserDetailsListUsecase.call(NoParams());

        isSuccesful.fold(
            (l) => {
                  if (l is ServerFailure)
                    {emit(GetCounsellorDetailsListFailedState())}
                  else if (l is CacheFailure)
                    {emit(GetCounsellorDetailsListFailedState())}
                },
            (r) => emit(GetCounsellorDetailsListLoadedState(userData: r)));
      },
    );

    on<CounsellorStatusDeleteEvent>(
      (event, emit) async {
        emit(DeleteCounsellorLoading());
        final isSuccesful = await deleteCounsellorUsecase.call(event.userdata);
        isSuccesful.fold((l) {
          if (l is ServerFailure) {
            emit(DeleteCounsellorFailed());
          } else if (l is CacheFailure) {
            emit(DeleteCounsellorFailed());
          }
        }, (r) {
          emit(DeletCounsellorLoaded());
          add(GetCounsellorDetailsEvent());
        });
      },
    );
  }
}
