import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user_profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:frontend/injectable.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  var getUserProfileUsecase = getIt<GetUserProfileUsecase>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  UserProfileBloc() : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetUserProfileEvent>(
      (event, emit) async {
        emit(GetUserProfileLoadingState());

        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();

        print("i am in GetUserProfileEvent bloc heppeno");

        print(userInfo!.id!);

        final isSuccessful = await getUserProfileUsecase.call(userInfo!.id!);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetUserProfileFailedState());
          } else if (l is CacheFailure) {
            emit(GetUserProfileFailedState());
          }
        }, (r) {
          emit(GetUserProfileLoadedState(getUserData: r));
        });
      },
    );
  }
}
