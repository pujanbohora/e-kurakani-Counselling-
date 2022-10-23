//RouteGenerator

// ignore_for_file: constant_identifier_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/BusinessUser_Dashboard/view/BusinessUser_Dash.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/CounsellorUser_Dasboard/view/CounsellorUser_Dash.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/NoramlUser_Dashboard/view/NormalUser_Dash.dart';
import 'package:frontend/features/Schedule/presentaion/view/schedule_list_page.dart';
import 'package:frontend/features/appointment/past_appointments/presentation/pages/user_past_appointment_page.dart';

// import 'package:frontend/features/VerifyAccount_byAdmin/presentation/pages/displayCounsellor_verification.dart';
// import 'package:frontend/features/VerifyAccount_byAdmin/presentation/pages/displayfile_verification.dart';
// import 'package:frontend/features/VerifyAccount_byAdmin/presentation/pages/profilerequest_list.dart';

// Project imports:
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_category_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_request_for_appointment_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_sub_category_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_detail_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_page.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/view/appointments_list.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/view/customer_appointments_list.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/pages/create_counsellor/list_counsellor_page.dart';
import 'package:frontend/features/auth/forgot_password/presentation/pages/create_new_password.dart';
import 'package:frontend/features/auth/forgot_password/presentation/pages/forgot_password.dart';
import 'package:frontend/features/auth/forgot_password/presentation/pages/opt_screen.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/email_verification/view/verify_email.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_in/view/sign_in_view.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/view/bussiness_user_sign_up_view.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/view/sign_up_view.dart';
import 'package:frontend/features/auth/user/presentation/pages/userlist/userlist.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/userprofile.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/view_account_page.dart';
import 'package:frontend/features/category/presentation/pages/add_category/view/add_category_page.dart';
import 'package:frontend/features/landing_page/presntation/pages/Landingpage.dart';
import 'package:frontend/features/payment/presentation/pages/payment_page.dart';
import 'package:frontend/features/onboardingPage/presentation/onboardpage.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/presentation/pages/apply_button_page.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/counsellor_attachment_upload_page.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/add_counsellor_schedule.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/add_counsellor_timetable_page.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/apply_counsellor_profile_page.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/displayCounsellor_verification.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/profilerequest_list.dart';
import 'package:frontend/features/report/presentation/view/counsellor_call_report_screen.dart';

import '../../features/auth/create_counsellor/presentation/pages/create_counsellor/view/create_counsellor_screen.dart';

import '../../features/BottomNavbar/Nav_Admin.dart';
import '../../features/BottomNavbar/Nav_Business.dart';
import '../../features/BottomNavbar/Nav_Counsellor.dart';
import '../../features/BottomNavbar/Nav_Normal.dart';

class Routes {
  static const String SPLASH_SCREEN = "/splash";
  static const String SIGN_UP_SCREEN = "/signup";
  static const String BUSSINESS_USER_REGISTRATION_SCREEN =
      "/bussiness-user/register";
  static const String GENERAL_USER_REGISTRATION_SCREEN =
      "/general-user/register";
  static const String SIGN_IN = "/sign-in";
  static const String BottNav_Admin = "/bottom-nav";
  static const String BottNav_Counsellor = "/bottomNav-counsellor";
  static const String BottNav_Customer = "/bottomNav-normal";
  static const String BottNav_Business = "/bottomNav-business";
  static const String FORGOT_PASSWORD = "/forgot-password";
  static const String CREATE_NEW_PASSWORD = "/create-new-password";

  static const String ADD_CATEGORY = "/add-category";
  static const String ROUTE_LANDING = "/landing";
  static const String CREATE_REQUEST_CATEGORY_VIEW_SCREEN =
      "/create-request-categiry-view";
  static const String CREATE_REQUEST_SUB_CATEGORY_VIEW_SCREEN =
      "/create-request-sub-category-view";
  static const String CREATE_REQUEST_VIEW_COUNSELLOR_SCREEN =
      "/create-request-sub-category-view-counsellor";
  static const String CREATE_REQUEST_VIEW_COUNSELLOR_DETAIL_SCREEN =
      "/create-request-sub-category-view-counsellor-detail";
  static const String CREATE_REQUEST_REQUEST_FOR_APPOINTMENT_VIEW_SCREEN =
      "/create-request-request-for-appointment";
  static const String CREATE_COUNSELLOR = "/create-counsellor";
  static const String APPOINTMENTLIST = "/appointment-list";
  static const String CUSTOMER_APPOINTMENT_LIST = "/customer-appointment-list";
  static const String VERIFY_EMAIL = "/verify-email";
  static const String APPROVE_SCREEN = "/approve";
  static const String APPLY_COUNSELLOR_BUTTON = "/apply-counsellor-button";
  static const String APPLY_COUNSELLOR_SCREEN = "/apply-counsellor-screen";
  static const String APPOINTMENT_DETAILS = "/appointment-details";
  static const String ADD_MONTHLY_TIME_TABLE_SCREEN =
      "/add-monthl-timetable-screen";
  static const String ADD_SCHEDULE_SCREEN = "/add-schedule-screen";
  static const String COUNSELLOR_ATTACHMENT_UPLOAD_SCREEN =
      "/counsellor-attachment-upload-screen";
  static const String PAYMENT_SCREEN = "/khalti-payment";

  static const String FORGET_PASSWORD_OTP_SCREEN = "/forget-passord/otp";

  static const String Display_CounsellorVerification = "/verify-counseller";
  static const String DisplayFileVerification = "/display-files";
  static const String ProfilerequestList = "/profilereq-list";

  static const String OnboardingPage = "/onboarding-screen";
  static const String NormalUserDashboard = "/normal-dashboard";
  static const String BusinessDashboard = "/business-dashboard";
  static const String CounsellorDashboard = "/counsellor-dash";
  static const String UserList = "/user-list";
  static const String EditProfilePage = "/edituser-profile";
  static const String VIEW_ACCOUNT_SCREEN = "/account-profile";
  static const String CHANGE_PASSWORD_SCREEN = "/account-profile";
  static const String SCHEDULE_LIST_SCREEN = "/schedule-list-user";
  static const String PAST_APPOINTMENT = "/past-appointment";
  static const String COUNSELLOR_CALL_REPORT = "/call-report";
  static const String LIST_BUSINESS_COUNSELLORS = "/list-business-counsellors";
  static const String ADD_BUSINESS_COUNSELLORS = "/add-business-counsellors";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.SPLASH_SCREEN:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.SIGN_UP_SCREEN:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case Routes.BUSSINESS_USER_REGISTRATION_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const BussinessUserSignupPage());
      case Routes.GENERAL_USER_REGISTRATION_SCREEN:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case Routes.SIGN_IN:
        return MaterialPageRoute(builder: (_) => const SigninPage());

      case Routes.FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      case Routes.FORGET_PASSWORD_OTP_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const ForgetPasswordOTPScreen());

      case Routes.CREATE_NEW_PASSWORD:
        return MaterialPageRoute(
            builder: (_) =>
                CreateNewPassword(otp: settings.arguments as String));
// --------------------------------Role wise BottomNavbar route----------------------------------------------------
      case Routes.BottNav_Admin:
        return MaterialPageRoute(builder: (_) => const BottNavAdmin());

      case Routes.BottNav_Counsellor:
        return MaterialPageRoute(builder: (_) => const BottNavCounsellor());

      case Routes.BottNav_Customer:
        return MaterialPageRoute(builder: (_) => const BottNavNormal());

      case Routes.BottNav_Business:
        return MaterialPageRoute(builder: (_) => const BottNavBusiness());
      //  --------------------BottomNav------------------------------------

      case Routes.OnboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case Routes.NormalUserDashboard:
        return MaterialPageRoute(builder: (_) => const NormalUserDashboard());

      case Routes.BusinessDashboard:
        return MaterialPageRoute(builder: (_) => const BusinessDashboard());

      case Routes.CounsellorDashboard:
        return MaterialPageRoute(builder: (_) => CounsellorDashboard());
      case Routes.UserList:
        return MaterialPageRoute(builder: (_) => const UserList());

      case Routes.EditProfilePage:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      case Routes.VIEW_ACCOUNT_SCREEN:
        return MaterialPageRoute(builder: (_) => ViewAccountScreen());

      case Routes.PAST_APPOINTMENT:
        return MaterialPageRoute(builder: (_) => UserPastAppointmentScreen());

      // case Routes.UpperNavNormalUser:
      // return MaterialPageRoute(builder: (_)=> const UpperNavNormalUser());

      case Routes.Display_CounsellorVerification:
        return MaterialPageRoute(
          builder: (_) => DisplayCounsellorVerificationRequest(
            counsellorProfileData: CounsellorProfile(),
          ),
        );

      // case Routes.DisplayFileVerification:
      //   return MaterialPageRoute(
      //       builder: (_) => const DisplayFileVerification());

      case Routes.ProfilerequestList:
        return MaterialPageRoute(builder: (_) => const ProfilerequestList());

      case Routes.ADD_CATEGORY:
        return MaterialPageRoute(builder: (_) => const AddCategoryScreen());
      case Routes.ROUTE_LANDING:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const CreateRequestCategoryViewScreen());
      case Routes.CREATE_REQUEST_SUB_CATEGORY_VIEW_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const CreateRequestSubCategoryViewScreen());
      case Routes.CREATE_REQUEST_VIEW_COUNSELLOR_DETAIL_SCREEN:
        return MaterialPageRoute(
          builder: (_) => CreateRequestViewCounsellorDetailScreen(
            counsellorData: CounsellorProfileModel(),
          ),
        );
      case Routes.CREATE_REQUEST_VIEW_COUNSELLOR_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const CreateRequestViewCounsellorScreen());
      case Routes.CREATE_REQUEST_REQUEST_FOR_APPOINTMENT_VIEW_SCREEN:
        return MaterialPageRoute(
            builder: (_) =>
                const CreateRequestRequestForAppointmentViewScreen());
      case Routes.CREATE_COUNSELLOR:
        return MaterialPageRoute(
            builder: (_) => const CreateBussinessCounsellorScreen());
      case Routes.APPOINTMENTLIST:
        return MaterialPageRoute(builder: (_) => AppointmentsList());
      case Routes.CUSTOMER_APPOINTMENT_LIST:
        return MaterialPageRoute(
            builder: (_) => const CustomerAppointmentsList());
      case Routes.COUNSELLOR_CALL_REPORT:
        return MaterialPageRoute(builder: (_) => CounsellorCallReportPage());

      case Routes.VERIFY_EMAIL:
        return MaterialPageRoute(builder: (_) => const EmailScreen());
      case Routes.APPLY_COUNSELLOR_BUTTON:
        return MaterialPageRoute(
            builder: (_) => const ApplyCounsellorButtonScreen());
      case Routes.COUNSELLOR_ATTACHMENT_UPLOAD_SCREEN:
        return MaterialPageRoute(
            builder: (_) => CounsellorAttachmentUploadScreen(
                counsellorId: settings.arguments as String));
      case Routes.PAYMENT_SCREEN:
        return MaterialPageRoute(builder: (_) => const KhaltiPaymentPage());
      case Routes.APPLY_COUNSELLOR_SCREEN:
        return MaterialPageRoute(
            builder: (_) => ApplyCounsellorProfileScreen(
                userId: settings.arguments as String));
      case Routes.SCHEDULE_LIST_SCREEN:
        return MaterialPageRoute(builder: (_) => ScheduleListScreen());

      case Routes.ADD_MONTHLY_TIME_TABLE_SCREEN:
        return MaterialPageRoute(
            builder: (_) => AddCounsellorTimeTableScreen(
                userId: settings.arguments as String));
      case Routes.ADD_SCHEDULE_SCREEN:
        return MaterialPageRoute(
            builder: (_) => AddCounsellorScheduleScreen(
                userId: settings.arguments as String));

      case Routes.LIST_BUSINESS_COUNSELLORS:
        return MaterialPageRoute(builder: (_) => CounsellorList());
      case Routes.ADD_BUSINESS_COUNSELLORS:
        return MaterialPageRoute(
            builder: (_) => CreateBussinessCounsellorScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

class UndefinedRoute extends StatelessWidget {
  const UndefinedRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("undefined route")),
    );
  }
}

//Navigator.pushNamed(context, BUSSINESS_USER_REGISTRATION_SCREEN);
