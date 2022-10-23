// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/Dashboard/Presentation/bloc/dashboard_bloc.dart';
import 'package:frontend/features/Schedule/presentaion/bloc/schedule_list_bloc.dart';
import 'package:frontend/features/appointment/past_appointments/presentation/bloc/past_appointment_bloc.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/check_counsellor_status_bloc/check_counsellor_status_bloc.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/createcounsellor_bloc.dart';
import 'package:frontend/features/auth/forgot_password/presentation/bloc/forget_password_bloc.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/bloc/upcoming_appointment/upcoming_appointment_bloc.dart';
import 'package:frontend/features/auth/user/presentation/check_user_status_bloc/check_user_status_bloc.dart';
import 'package:frontend/features/auth/user_profile/presentation/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:frontend/features/auth/user_profile/presentation/user_profile_bloc/user_profile_bloc.dart';
import 'package:frontend/features/profiles/domain/usecases/business_profile_usecase.dart';
import 'package:frontend/features/profiles/presentation/bloc/business_bloc/business_bloc.dart';
import 'package:frontend/features/profiles/presentation/bloc/counsellor_bloc/counsellor_bloc.dart';
import 'package:frontend/features/report/presentation/bloc/feedback_bloc/counsellor_feedback_bloc.dart';
import 'package:frontend/features/report/presentation/bloc/report_bloc/report_bloc.dart';
import 'package:frontend/khaltikeys.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/usecasess/get_counsellors_category_usecases.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/usecasess/save_request_appointment_usecase.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/bloc/create_request_bloc/create_request_bloc.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/email_verification_usecase.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/login_with_pasword.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/sign_up_register_user.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:frontend/features/category/domain/usecases/add_category_usecase.dart';
import 'package:frontend/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_profile_usecase.dart';
import 'package:frontend/features/profiles/presentation/bloc/profile_request/profile_request_bloc.dart';
import 'package:frontend/get_current_user.dart';
import 'package:frontend/injectable.dart';
import 'features/auth/sign_up/presentation/bloc/email_verify_bloc/email_bloc.dart';
import 'features/auth/user/presentation/get_user_details_list_bloc/get_user_details_list_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  final isAuthenticated = await getCurrentUser;
  runApp(EKurakani(isAuthenticated: isAuthenticated));
}

class EKurakani extends StatefulWidget {
  final bool isAuthenticated;
  const EKurakani({Key? key, required this.isAuthenticated}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EKurakaniState();
}

class _EKurakaniState extends State<EKurakani> {
  var signUpRepositorUser = getIt<SignUpRegisterUser>();
  var loginWithPasswordUsecase = getIt<LoginWithPassword>();
  var saveRequestForAppointment = getIt<SaveRequestForAppointment>();
  var preference = getIt<SharedPreferences>();
  var addCategoryUsecase = getIt<AddcategoryUsecase>();

  var getCategoryUsecase = getIt<GetCategoryUsecase>();
  var getCounsellorsCategoryUsecases = getIt<GetCounsellorsCategoryUsecases>();
  final prefs = getIt<SharedPreferences>();
  var emailVerification = getIt<EmailVerification>();
  var getCounsellorProfileUsecase = getIt<GetCounsellorProfileUsecase>();
  var getBusinessProfileUsecase = getIt<GetBusinessProfileUsecase>();

  @override
  Widget build(BuildContext context) {
    var _remeberMe = prefs.getBool("remember_me") ?? false;
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmailBloc>(
          create: (context) => EmailBloc(emailVerification),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => ForgetPasswordBloc(),
        ),
        BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(addCategoryUsecase, getCategoryUsecase)
                  ..add(GetCategoryEvent())),
        BlocProvider<SubCategoryBloc>(
          create: (context) => SubCategoryBloc()
            ..add(
              GetSubCategoryEvent(),
            ),
        ),
        BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
                loginWithPasswordUsecase, signUpRepositorUser, preference)),
        BlocProvider<CreateRequestBloc>(
          create: (context) => CreateRequestBloc(
              saveRequestForAppointment, getCounsellorsCategoryUsecases),
        ),
        BlocProvider<CounsellorBloc>(
            create: (context) => CounsellorBloc(getCounsellorProfileUsecase)),
        BlocProvider<ProfileRequestBloc>(
          create: (context) => ProfileRequestBloc(),
        ),
        BlocProvider<UpcomingAppointmentBloc>(
          create: (context) => UpcomingAppointmentBloc(),
        ),
        BlocProvider<GetUserDetailsListBloc>(
          create: (context) =>
              GetUserDetailsListBloc()..add(GetUserDetailsEvent()),
        ),
        BlocProvider<CheckUserStatusBloc>(
            create: (context) => CheckUserStatusBloc()),
        BlocProvider<UpcomingCustomerAppointmentBloc>(
          create: (context) => UpcomingCustomerAppointmentBloc()
            ..add(GetCustomerUpcomingAppointmentEvent()),
        ),
        BlocProvider<UserProfileBloc>(
            create: (context) => UserProfileBloc()..add(GetUserProfileEvent())),
        BlocProvider<EditUserProfileBloc>(
            create: (context) => EditUserProfileBloc()),
        BlocProvider<BusinessBloc>(
            create: (context) => BusinessBloc(getBusinessProfileUsecase)),
        BlocProvider<DeleteCategoryBloc>(
          create: (context) => DeleteCategoryBloc(),
        ),
        BlocProvider<ScheduleListBloc>(
          create: (context) => ScheduleListBloc()..add(GetScheduleListEvent()),
        ),
        BlocProvider<PastAppointmentBloc>(
          create: (context) =>
              PastAppointmentBloc()..add(GetPastAppointmentEvent()),
        ),
        BlocProvider<CounsellorFeedbackBloc>(
          create: (context) => CounsellorFeedbackBloc(),
        ),
        BlocProvider<ReportBloc>(
          create: (context) => ReportBloc(),
        ),
        BlocProvider<CreatecounsellorBloc>(
          create: (context) =>
              CreatecounsellorBloc()..add(GetCounsellorDetailsEvent()),
        ),
        BlocProvider<CheckCounsellorStatusBloc>(
            create: (context) => CheckCounsellorStatusBloc()),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: KhaltiScope(
        publicKey: KhaltiKeys.publicKeys,
        builder: (context, navigatorKey) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 214, 240, 249),
                Color.fromARGB(255, 243, 243, 243),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            )),
            child: MaterialApp(
              // : CustomTheme.lightTheme,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              navigatorKey: navigatorKey,
              theme: CustomTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,

              initialRoute:
                  // _remeberMe
                  // ? (widget.isAuthenticated)
                  //     ? Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN
                  //     : Routes.SIGN_IN
                  // :
                  Routes.SIGN_IN,
              // initialRoute: Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN,
            ),
          );
        },
      ),
    );
  }
}
