// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i102;

import 'core/config/cached_values.dart' as _i108;
import 'features/appointment/past_appointments/data/data_source/past_appointment_remote_data_source.dart'
    as _i79;
import 'features/appointment/past_appointments/data/repositories/past_appointment_repository_impl.dart'
    as _i81;
import 'features/appointment/past_appointments/domain/repository/past_appointment_repository.dart'
    as _i80;
import 'features/appointment/past_appointments/domain/usecases/past_appointment_usecase.dart'
    as _i82;
import 'features/appointment/request_for_appointment/data/data_source/get_counsellors_category_remote_data_source.dart'
    as _i70;
import 'features/appointment/request_for_appointment/data/data_source/save_create_request_appointment_remote_data_source.dart'
    as _i101;
import 'features/appointment/request_for_appointment/data/repositories/get_counsellors_category_impl.dart'
    as _i72;
import 'features/appointment/request_for_appointment/data/repositories/save_create_request_appointment_impl.dart'
    as _i110;
import 'features/appointment/request_for_appointment/domain/repository/get_counsellors_category_repository.dart'
    as _i71;
import 'features/appointment/request_for_appointment/domain/repository/save_request_appointment_repository.dart'
    as _i109;
import 'features/appointment/request_for_appointment/domain/usecasess/get_counsellors_category_usecases.dart'
    as _i73;
import 'features/appointment/request_for_appointment/domain/usecasess/save_request_appointment_usecase.dart'
    as _i112;
import 'features/appointment/upcoming_appointment/data/data_source/get_upcoming_schedule_remote_data_source.dart'
    as _i90;
import 'features/appointment/upcoming_appointment/data/repositories/get_upcoming_repository_impl.dart'
    as _i92;
import 'features/appointment/upcoming_appointment/domain/repository/get_upcoming_appointment_repository.dart'
    as _i91;
import 'features/appointment/upcoming_appointment/domain/usecases/get_upcoming_appointment_usecase.dart'
    as _i74;
import 'features/auth/create_counsellor/data/data_sources/create_counsellor_local_data_sources.dart'
    as _i30;
import 'features/auth/create_counsellor/data/data_sources/create_cousellor_remote_data_source.dart'
    as _i31;
import 'features/auth/create_counsellor/data/repositories/create_counsellor_repository_impl.dart'
    as _i33;
import 'features/auth/create_counsellor/domain/repository/create_counsellor_repository.dart'
    as _i32;
import 'features/auth/create_counsellor/domain/usecases/create_cousellor_usecase.dart'
    as _i34;
import 'features/auth/forgot_password/data/data_source/forget_password_email_verify_remote_data_source.dart'
    as _i54;
import 'features/auth/forgot_password/data/data_source/forget_password_otp_verify_remote_data_source.dart'
    as _i55;
import 'features/auth/forgot_password/data/data_source/forget_password_reset_password_remote_data_source.dart'
    as _i59;
import 'features/auth/forgot_password/data/repositories/forget_password_email_verify_repository_impl.dart'
    as _i52;
import 'features/auth/forgot_password/data/repositories/forget_password_otp_verify_repositories_impl.dart'
    as _i57;
import 'features/auth/forgot_password/data/repositories/forget_password_reset_password_repository_impl.dart'
    as _i61;
import 'features/auth/forgot_password/domain/repository/forget_password_email_verify_repository.dart'
    as _i51;
import 'features/auth/forgot_password/domain/repository/forget_password_otp_repository.dart'
    as _i56;
import 'features/auth/forgot_password/domain/repository/forget_password_reset_password_repository.dart'
    as _i60;
import 'features/auth/forgot_password/domain/usecases/forget_password_email_verify_usecase.dart'
    as _i53;
import 'features/auth/forgot_password/domain/usecases/forget_password_otp_usecase.dart'
    as _i58;
import 'features/auth/forgot_password/domain/usecases/forget_password_reset_password_usecase.dart'
    as _i62;
import 'features/auth/sign_up/data/data_sources/email_verification_remote_data_source.dart'
    as _i50;
import 'features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart'
    as _i103;
import 'features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart'
    as _i104;
import 'features/auth/sign_up/data/repositories/email_verify_repository_impl.dart'
    as _i48;
import 'features/auth/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i105;
import 'features/auth/sign_up/domain/repository/sign_up_repository.dart'
    as _i47;
import 'features/auth/sign_up/domain/usecases/email_verification_usecase.dart'
    as _i49;
import 'features/auth/sign_up/domain/usecases/login_with_pasword.dart' as _i111;
import 'features/auth/sign_up/domain/usecases/sign_up_register_user.dart'
    as _i113;
import 'features/auth/user/data/data_sources/check_user_status_remote_data_source.dart'
    as _i20;
import 'features/auth/user/data/data_sources/delete_user_remote_data_source.dart'
    as _i39;
import 'features/auth/user/data/data_sources/get_user_details_list_remote_data_source.dart'
    as _i93;
import 'features/auth/user/data/repositories/check_user_status_repository_impl.dart'
    as _i22;
import 'features/auth/user/data/repositories/delete_user_repository_impl.dart'
    as _i41;
import 'features/auth/user/data/repositories/get_user_details_list_repository_impl.dart'
    as _i95;
import 'features/auth/user/domain/repository/check_user_status_repository.dart'
    as _i21;
import 'features/auth/user/domain/repository/delete_user_repository.dart'
    as _i40;
import 'features/auth/user/domain/repository/get_user_details_list_repository.dart'
    as _i94;
import 'features/auth/user/domain/usecases/check_user_status_usecase.dart'
    as _i23;
import 'features/auth/user/domain/usecases/delete_user_usecase.dart' as _i42;
import 'features/auth/user/domain/usecases/get_user_details_list_usecase.dart'
    as _i96;
import 'features/auth/user_profile/data/data_source/change_password_remote_data_source.dart'
    as _i19;
import 'features/auth/user_profile/data/data_source/edit_user_profile_remote_data_source.dart'
    as _i43;
import 'features/auth/user_profile/data/data_source/get_user_profile_remote_data_source.dart'
    as _i97;
import 'features/auth/user_profile/data/repositories/edit_user_profile_repository_impl.dart'
    as _i45;
import 'features/auth/user_profile/data/repositories/get_user_profile_repository_impl.dart'
    as _i99;
import 'features/auth/user_profile/domain/repository/edit_user_profile_repository.dart'
    as _i44;
import 'features/auth/user_profile/domain/repository/get_user_profile_repository.dart'
    as _i98;
import 'features/auth/user_profile/domain/usecases/edit_user_profile_usecases.dart'
    as _i46;
import 'features/auth/user_profile/domain/usecases/get_user_profile_usecase.dart'
    as _i100;
import 'features/category/data/data_source/add_category_remote_data_source.dart'
    as _i3;
import 'features/category/data/data_source/delete_category_remote_data_source.dart'
    as _i36;
import 'features/category/data/data_source/get_category_remote_data_source.dart'
    as _i65;
import 'features/category/data/repositories/add_category_repository_impl.dart'
    as _i5;
import 'features/category/data/repositories/get_category_repository_impl.dart'
    as _i67;
import 'features/category/domain/repository/add_category_repository.dart'
    as _i4;
import 'features/category/domain/repository/get_category_repository.dart'
    as _i66;
import 'features/category/domain/usecases/add_category_usecase.dart' as _i10;
import 'features/Dashboard/data/data_sources/dashboard_remote_data_source.dart'
    as _i35;
import 'features/profiles/data/data_sources/add_attachment_remote_data_source.dart'
    as _i13;
import 'features/profiles/data/data_sources/apply_business_profile_remote_data_source.dart'
    as _i11;
import 'features/profiles/data/data_sources/apply_counsellor_profile_remote_data_source.dart'
    as _i12;
import 'features/profiles/data/data_sources/get_business_profile_remote_data_source.dart'
    as _i63;
import 'features/profiles/data/data_sources/get_counsellor_profile_remote_data_source.dart'
    as _i68;
import 'features/profiles/data/repository/attachment_repository_impl.dart'
    as _i15;
import 'features/profiles/data/repository/business_repository_impl.dart'
    as _i17;
import 'features/profiles/data/repository/counsellor_repository_impl.dart'
    as _i29;
import 'features/profiles/data/repository/get_business_profile_repository.dart'
    as _i64;
import 'features/profiles/data/repository/get_counsellor_profile_repository_impl.dart'
    as _i69;
import 'features/profiles/domain/repository/attachment_repository.dart' as _i14;
import 'features/profiles/domain/repository/business_repository.dart' as _i16;
import 'features/profiles/domain/repository/counsellor_repository.dart' as _i28;
import 'features/profiles/domain/usecases/add_attachment_usecase.dart' as _i106;
import 'features/profiles/domain/usecases/business_profile_usecase.dart'
    as _i18;
import 'features/profiles/domain/usecases/counsellor_profile_usecase.dart'
    as _i37;
import 'features/profiles/domain/usecases/counsellor_timetable_usecase.dart'
    as _i107;
import 'features/report/data/data_source/add_report_remote_data_source.dart'
    as _i6;
import 'features/report/data/data_source/counsellor_feedback_remote_data_source.dart'
    as _i24;
import 'features/report/data/data_source/get_feedback_remote_data_source.dart'
    as _i75;
import 'features/report/data/data_source/get_report_remote_data_source.dart'
    as _i83;
import 'features/report/data/repositories/add_report_repository_impl.dart'
    as _i8;
import 'features/report/data/repositories/counsellor_feedback_repository_impl.dart'
    as _i26;
import 'features/report/data/repositories/get_feedback_repository_impl.dart'
    as _i77;
import 'features/report/data/repositories/get_report_repository_impl.dart'
    as _i85;
import 'features/report/domain/repository/add_report_repository.dart' as _i7;
import 'features/report/domain/repository/cousellor_feedback_repository.dart'
    as _i25;
import 'features/report/domain/repository/ger_feedback_repository.dart' as _i76;
import 'features/report/domain/repository/get_report_repository.dart' as _i84;
import 'features/report/domain/usecases/add_report_usecase.dart' as _i9;
import 'features/report/domain/usecases/counsellor_feedback_usecases.dart'
    as _i27;
import 'features/report/domain/usecases/get_feedback_useCase.dart' as _i78;
import 'features/report/domain/usecases/get_report_useCase.dart' as _i86;
import 'features/Schedule/data/data_source/schedule_list_remote_data_source.dart'
    as _i87;
import 'features/Schedule/data/repository/schedule_list_repository_impl.dart'
    as _i89;
import 'features/Schedule/domain/repository/shedule_list_repository.dart'
    as _i88;
import 'features/Schedule/domain/usecases/schedule_list_usecase.dart'
    as _i38; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectionModule = _$InjectionModule();
  gh.factory<_i3.AddCategoryRemotedataSource>(
      () => _i3.AddCategoryRemotedataSourceImpl());
  gh.factory<_i4.AddCategoryRepository>(() => _i5.AddcategoryRepositoryImpl());
  gh.factory<_i6.AddReportRemotedataSource>(
      () => _i6.AddReportRemotedataSourceImpl());
  gh.factory<_i7.AddReportRepository>(() => _i8.AddReportRepositoryImpl());
  gh.factory<_i9.AddReportUsecase>(
      () => _i9.AddReportUsecase(get<_i7.AddReportRepository>()));
  gh.factory<_i10.AddcategoryUsecase>(
      () => _i10.AddcategoryUsecase(get<_i4.AddCategoryRepository>()));
  gh.factory<_i11.ApplyBusinessProfileRemotedataSource>(
      () => _i11.ApplyBusinessProfileRemotedataSourceImpl());
  gh.factory<_i12.ApplyCounsellorProfileRemotedataSource>(
      () => _i12.ApplyCounsellorProfileRemotedataSourceImpl());
  gh.factory<_i13.AttachmentRemotedataSource>(
      () => _i13.AttachmentRemotedataSourceImpl());
  gh.factory<_i14.AttachmentRepository>(() => _i15.AttachmentRepositoryImpl());
  gh.factory<_i16.BusinessProfileRepository>(
      () => _i17.BusinessProfileRepositoryImpl());
  gh.factory<_i18.ChangeBusinessProfileStatusUsecase>(() =>
      _i18.ChangeBusinessProfileStatusUsecase(
          get<_i16.BusinessProfileRepository>()));
  gh.factory<_i19.ChangePasswordRemoteDataSource>(
      () => _i19.ChangePasswordRemoteDataSourceImpl());
  gh.factory<_i20.CheckUserStatusRemoteDataSource>(
      () => _i20.GetUserDetailsListRemoteDataSourceImpl());
  gh.factory<_i21.CheckUserStatusRepository>(
      () => _i22.CheckUserStatusRepositoryImpl());
  gh.factory<_i23.CheckUserStatusUsecase>(() => _i23.CheckUserStatusUsecase());
  gh.factory<_i24.CounsellorFeedbacRemotedataSource>(
      () => _i24.CounsellorFeedbacRemotedataSourceImpl());
  gh.factory<_i25.CounsellorFeedbackRepository>(
      () => _i26.CounsellorFeedbackRepositoryImpl());
  gh.factory<_i27.CounsellorFeedbackUsecase>(() =>
      _i27.CounsellorFeedbackUsecase(get<_i25.CounsellorFeedbackRepository>()));
  gh.factory<_i28.CounsellorProfileRepository>(
      () => _i29.CounsellorProfileRepositoryImpl());
  gh.factory<_i30.CreateCounsellorLocalDataSource>(
      () => _i30.CreateCounsellorLocalDataSourceImpl());
  gh.factory<_i31.CreateCounsellorRemoteDataSource>(
      () => _i31.CreateCounsellorRemoteDataSourceImpl());
  gh.factory<_i32.CreateCounsellorRepository>(() =>
      _i33.CreateCounsellorRepositoryImpl(
          createCounsellorRemoteDataSource:
              get<_i31.CreateCounsellorRemoteDataSource>()));
  gh.factory<_i34.CreateCounsellorUsecase>(() =>
      _i34.CreateCounsellorUsecase(get<_i32.CreateCounsellorRepository>()));
  gh.factory<_i35.DashboardRemoteDataSource>(
      () => _i35.DashboardRemoteDataSourceImpl());
  gh.factory<_i18.DeleteBusinessAttachmentUseCase>(
      () => _i18.DeleteBusinessAttachmentUseCase());
  gh.factory<_i36.DeleteCategoryRemoteDataSource>(
      () => _i36.DeleteCategoryRemoteDataSourceImpl());
  gh.factory<_i37.DeleteCounsellorAttachmentUseCase>(
      () => _i37.DeleteCounsellorAttachmentUseCase());
  gh.factory<_i38.DeleteScheduleUseCase>(() => _i38.DeleteScheduleUseCase());
  gh.factory<_i39.DeleteUserRemoteDataSource>(
      () => _i39.DeleteUserRemoteDataSourceImpl());
  gh.factory<_i40.DeleteUserRepository>(() => _i41.DeleteUserRepositoryImpl());
  gh.factory<_i42.DeleteUserUsecase>(() => _i42.DeleteUserUsecase());
  gh.factory<_i18.EditBusinessProfileUsecase>(() =>
      _i18.EditBusinessProfileUsecase(get<_i16.BusinessProfileRepository>()));
  gh.factory<_i37.EditCounsellorProfileUsecase>(() =>
      _i37.EditCounsellorProfileUsecase(
          get<_i28.CounsellorProfileRepository>()));
  gh.factory<_i43.EditUserProfileRemoteDataSource>(
      () => _i43.EditUserProfileRemoteDataSourceImpl());
  gh.factory<_i44.EditUserProfileRepository>(
      () => _i45.EditUserProfileRepositoryImpl());
  gh.factory<_i46.EditUserProfileUsecase>(() => _i46.EditUserProfileUsecase());
  gh.factory<_i47.EmailVerficationRepository>(
      () => _i48.EmailVerifyRepositoryImpl());
  gh.factory<_i49.EmailVerification>(() => _i49.EmailVerification());
  gh.factory<_i50.EmailVerificationRemoteDataSource>(
      () => _i50.EmailVerificationRemoteDataSourceImpl());
  gh.factory<_i51.ForgetPasswordEmailVerficationRepository>(
      () => _i52.ForgetPasswordEmailVerifyRepositoryImpl());
  gh.factory<_i53.ForgetPasswordEmailVerification>(
      () => _i53.ForgetPasswordEmailVerification());
  gh.factory<_i54.ForgetPasswordEmailVerificationRemoteDataSource>(
      () => _i54.ForgetPasswordEmailVerificationRemoteDataSourceImpl());
  gh.factory<_i55.ForgetPasswordOTPVerifyRemoteDataSource>(
      () => _i55.ForgetPasswordOTPVerifyRemoteDataSourceImpl());
  gh.factory<_i56.ForgetPasswordOTPVerifyRepository>(
      () => _i57.ForgetPasswordEmailVerifyRepositoryImpl());
  gh.factory<_i58.ForgetPasswordOTPVerifyUsecase>(
      () => _i58.ForgetPasswordOTPVerifyUsecase());
  gh.factory<_i59.ForgetPasswordResetPasswordRemoteDataSource>(
      () => _i59.ForgetPasswordResetPasswordRemoteDataSourceImpl());
  gh.factory<_i60.ForgetPasswordResetPasswordRepository>(
      () => _i61.ForgetPasswordResetPasswordImpl());
  gh.factory<_i62.ForgetPasswordResetPasswordUsecase>(
      () => _i62.ForgetPasswordResetPasswordUsecase());
  gh.factory<_i63.GetBusinessProfileRemotedataSource>(
      () => _i63.GetBusinessProfileRemotedataSourceImpl());
  gh.factory<_i16.GetBusinessProfileRepository>(
      () => _i64.GetBusinessProfileRepositoryImpl());
  gh.factory<_i18.GetBusinessProfileRequestUsecase>(
      () => _i18.GetBusinessProfileRequestUsecase());
  gh.factory<_i18.GetBusinessProfileUsecase>(
      () => _i18.GetBusinessProfileUsecase());
  gh.factory<_i65.GetCategoryRemotedataSource>(
      () => _i65.AddCategoryRemotedataSourceImpl());
  gh.factory<_i66.GetCategoryRepository>(
      () => _i67.GetcategoryRepositoryImpl());
  gh.factory<_i10.GetCategoryUsecase>(() => _i10.GetCategoryUsecase());
  gh.factory<_i68.GetCounsellorProfileRemotedataSource>(
      () => _i68.GetCounsellorProfileRemotedataSourceImpl());
  gh.factory<_i28.GetCounsellorProfileRepository>(
      () => _i69.GetCounsellorProfileRepositoryImpl());
  gh.factory<_i37.GetCounsellorProfileRequestUsecase>(
      () => _i37.GetCounsellorProfileRequestUsecase());
  gh.factory<_i37.GetCounsellorProfileUsecase>(
      () => _i37.GetCounsellorProfileUsecase());
  gh.factory<_i70.GetCounsellorsCategoryRemoteDataSource>(
      () => _i70.GetCounsellorsCategoryRemoteDataSourceImpl());
  gh.factory<_i71.GetCounsellorsCategoryRepository>(
      () => _i72.GetCounsellorsCategoryRepositoryImpl());
  gh.factory<_i73.GetCounsellorsCategoryUsecases>(() =>
      _i73.GetCounsellorsCategoryUsecases(
          getCounsellorsCategoryRepository:
              get<_i71.GetCounsellorsCategoryRepository>()));
  gh.factory<_i74.GetCustomerUpcomingAppointmentUsecase>(
      () => _i74.GetCustomerUpcomingAppointmentUsecase());
  gh.factory<_i75.GetFeedbackRemotedataSource>(
      () => _i75.GetRportRemotedataSourceImpl());
  gh.factory<_i76.GetFeedbackRepository>(
      () => _i77.GetFeedbackRepositoryImpl());
  gh.factory<_i78.GetFeedbackUsecase>(() => _i78.GetFeedbackUsecase());
  gh.factory<_i79.GetPastAppointmentRemoteSource>(
      () => _i79.GetPastAppointmentRemoteSourceImpl());
  gh.factory<_i80.GetPastAppointmentRespository>(
      () => _i81.GetPastAppointmentRespositoryImpl());
  gh.factory<_i82.GetPastAppointmentUsecase>(
      () => _i82.GetPastAppointmentUsecase());
  gh.factory<_i83.GetReportRemotedataSource>(
      () => _i83.GeteportRemotedataSourceImpl());
  gh.factory<_i84.GetReportRepository>(
      () => _i85.CounsellorFeedbackRepositoryImpl());
  gh.factory<_i86.GetReportUsecase>(() => _i86.GetReportUsecase());
  gh.factory<_i87.GetScheduleListRemoteDataSource>(
      () => _i87.EmailVerificationRemoteDataSourceImpl());
  gh.factory<_i88.GetScheduleListRepository>(
      () => _i89.GetScheduleListRepositoryImpl());
  gh.factory<_i38.GetScheduleListUsecase>(() => _i38.GetScheduleListUsecase());
  gh.factory<_i10.GetSubCategoryUsecase>(() => _i10.GetSubCategoryUsecase());
  gh.factory<_i74.GetUpcomingAppointmentDetailUsecase>(
      () => _i74.GetUpcomingAppointmentDetailUsecase());
  gh.factory<_i90.GetUpcomingAppointmentRemoteSource>(
      () => _i90.GetUpcomingAppointmentRemoteSourceImpl());
  gh.factory<_i91.GetUpcomingAppointmentRespository>(
      () => _i92.GetUpcomingAppointmentRespositoryImpl());
  gh.factory<_i74.GetUpcomingAppointmentUsecase>(
      () => _i74.GetUpcomingAppointmentUsecase());
  gh.factory<_i93.GetUserDetailsListRemoteDataSource>(
      () => _i93.GetUserDetailsListRemoteDataSourceImpl());
  gh.factory<_i94.GetUserDetailsListRepository>(
      () => _i95.GetUserDetailsListRepositoryImpl());
  gh.factory<_i96.GetUserDetailsListUsecase>(
      () => _i96.GetUserDetailsListUsecase());
  gh.factory<_i97.GetUserProfileRemoteDataSource>(
      () => _i97.GetUserProfileRemoteDataSourceImpl());
  gh.factory<_i98.GetUserProfileRepository>(
      () => _i99.GetUserProfileRepositoryImpl());
  gh.factory<_i100.GetUserProfileUsecase>(() => _i100.GetUserProfileUsecase());
  gh.factory<_i101.SaveCreateRequestAppointmentRemoteDataSource>(
      () => _i101.SaveCreateRequestAppointmentRemoteDataSourceImpl());
  await gh.factoryAsync<_i102.SharedPreferences>(
      () => injectionModule.preference,
      preResolve: true);
  gh.factory<_i103.SignUpLocalDataSource>(
      () => _i103.SignUpLocalDataSourceImpl());
  gh.factory<_i104.SignUpRemoteDataSource>(
      () => _i104.SignUpRemoteDataSourceImpl());
  gh.factory<_i47.SignUpRepository>(() => _i105.SignUpRepositoryImpl(
      signUpRemoteDataSource: get<_i104.SignUpRemoteDataSource>()));
  gh.factory<_i106.AddAttachment>(
      () => _i106.AddAttachment(get<_i14.AttachmentRepository>()));
  gh.factory<_i106.AddBusinessAttachment>(
      () => _i106.AddBusinessAttachment(get<_i14.AttachmentRepository>()));
  gh.factory<_i107.AddCounsellorScheduleUsecase>(() =>
      _i107.AddCounsellorScheduleUsecase(
          get<_i28.CounsellorProfileRepository>()));
  gh.factory<_i107.AddCounsellorTimeTableUsecase>(() =>
      _i107.AddCounsellorTimeTableUsecase(
          get<_i28.CounsellorProfileRepository>()));
  gh.factory<_i18.ApplyBusinessProfileUsecase>(() =>
      _i18.ApplyBusinessProfileUsecase(get<_i16.BusinessProfileRepository>()));
  gh.factory<_i37.ApplyCounsellorProfileUsecase>(() =>
      _i37.ApplyCounsellorProfileUsecase(
          get<_i28.CounsellorProfileRepository>()));
  gh.factory<_i108.CachedValues>(
      () => _i108.CachedValues(get<_i102.SharedPreferences>()));
  gh.factory<_i37.ChangeCounsellorProfileStatusUsecase>(() =>
      _i37.ChangeCounsellorProfileStatusUsecase(
          get<_i28.CounsellorProfileRepository>()));
  gh.factory<_i109.CreateRequestAppointmentRepository>(() =>
      _i110.CreateRequestAppointmentRepositoryImpl(
          saveCreateRequestAppointmentRemoteDataSource:
              get<_i101.SaveCreateRequestAppointmentRemoteDataSource>()));
  gh.factory<_i111.LoginWithPassword>(
      () => _i111.LoginWithPassword(get<_i47.SignUpRepository>()));
  gh.factory<_i112.SaveRequestForAppointment>(() =>
      _i112.SaveRequestForAppointment(
          createRequestAppointmentRepository:
              get<_i109.CreateRequestAppointmentRepository>()));
  gh.factory<_i113.SignUpRegisterUser>(
      () => _i113.SignUpRegisterUser(get<_i47.SignUpRepository>()));
  return get;
}

class _$InjectionModule extends _i103.InjectionModule {}
