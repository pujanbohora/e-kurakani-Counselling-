//connected to network of not

// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings, non_constant_identifier_names

class Urls {
  static const BASE_URL =
      "https://98f1-113-199-226-25.in.ngrok.io/api/rest/v1/"; // start ngrok and update each time
  static const REGISTER_URL = BASE_URL + "core/user-register/";
  static const LOGIN_WITH_PASSWORD = BASE_URL + "core/user-login/";
  static const CREATE_REQUEST_APPOINTMENT = BASE_URL + "appointment/generate/";
  static const ADD_CATEGORY = BASE_URL + 'category/';
  static const GET_CATEGORY = BASE_URL + 'category/';
  static const GET_SUB_CATEGORY = BASE_URL + 'category/sub-categories/';
  static const VERIFY_EMAIL_URL = BASE_URL + "core/verify-email/";
  static const UPCOMING_APPOINTMENTS = BASE_URL + "appointment/generate/";
  static const GET_SCHEDULE_LIST = BASE_URL + "profiles/my-schedule/";
  static const ADD_SCHEDULE_URL = BASE_URL + "profiles/schedule/";

  static const REPORT = BASE_URL + 'appointment/report/';
  static const DASHBOARD_URL = BASE_URL + 'appointment/dashboard-data/';

  //reset password
  static const RESET_PASSWORD_EMAIL = BASE_URL + 'core/forget-password/';
  static const RESET_PASSWORD_OTP = BASE_URL + "core/reset-code/";
  static const RESET_NEW_PASSWORD = BASE_URL + "core/reset-password/";

  static const GET_COUNSELLOR_APPOINTMENTS =
      BASE_URL + "appointment/counsellor-business-appointments/";
  static const PAST_APPOINTMENTS = BASE_URL + "appointment/past-appointment/";
  static getCounsellorCategory(String categoryId) =>
      "${BASE_URL}category/$categoryId/counsellors/";
  static const APPLY_COUNSELLOR_PROFILE =
      BASE_URL + "profiles/counsellor-profile/";
  static const COUNSELLOR_PROFILE_REQUESTS =
      BASE_URL + "profiles/applied-counsellor-profiles/";
  static const BUSINESS_PROFILE_REQUESTS =
      BASE_URL + "profiles/applied-business-profiles/";

  static String getCounsellorProfile(String id) {
    return BASE_URL + "profiles/get-counsellor-profile/$id/";
  }

  static String profileAttachmentUrl(String id) {
    return BASE_URL + "profiles/attachments/$id/";
  }

  static String getBusinessProfile(String id) {
    return BASE_URL + "profiles/get-business-profile/$id/";
  }

  static String getAppointmentDetail(String appointmentId) {
    return BASE_URL + "appointment/generate/$appointmentId/";
  }

  static String PAYMENT_WITH_CREATE_APPOINTMENT =
      BASE_URL + "appointment/khalti-verify/";

  static String updateCounsellorApplication(String id) {
    return BASE_URL + "profiles/counsellor-profile/$id/";
  }

  static String updateBusinessApplication(String id) {
    return BASE_URL + "profiles/business-profile/$id/";
  }

  static const ADD_MONTH_TIMETABLE_URL =
      BASE_URL + "profiles/create-month-timetable/";
  static String addCounsellorAttachments(String id) {
    return BASE_URL + "profiles/$id/counsellor/attachments/";
  }

  static String updateCounsellorAttachments(
      String counsellorId, String attachmentId) {
    return BASE_URL +
        "profiles/$counsellorId/counsellor/attachments/$attachmentId/";
  }

  static String addBusinessAttachments(String id) {
    return BASE_URL + "profiles/$id/business/attachments/";
  }

  static String updateBusinessAttachments(
      String businessId, String attachmentId) {
    return BASE_URL +
        "profiles/$businessId/business/attachments/$attachmentId/";
  }

  static const GET_USER_ACCOUNT = BASE_URL + "core/user-account/";

  static const EDIT_USER_ACCOUNT = BASE_URL + "core/user-details/";

  static const CHAGNE_PASSWORD = BASE_URL + 'core/change-password/';

  //admin
  static const USER_LIST = BASE_URL + "core/user/";
  static const DELETE_CATEGORY = BASE_URL + "category/";

  static const COUNSELLOR_FEEDBACK = BASE_URL + "appointment/feedback/";
}
