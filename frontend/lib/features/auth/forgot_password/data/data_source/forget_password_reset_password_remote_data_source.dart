// this is for api

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/verify_email_model.dart';

abstract class ForgetPasswordResetPasswordRemoteDataSource {
  Future<bool> changePassword(User userData);
}

@Injectable(as: ForgetPasswordResetPasswordRemoteDataSource)
class ForgetPasswordResetPasswordRemoteDataSourceImpl
    implements ForgetPasswordResetPasswordRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<bool> changePassword(User userData) async {
    UserModel userModelData = UserModel(
        email: userData.email, password: userData.password, otp: userData.otp);

    var userDataJson = userModelData.toJson();

    userDataJson.removeWhere((key, value) => key == "id");
    userDataJson.removeWhere((key, value) => key == "user_role");
    userDataJson.removeWhere((key, value) => key == "is_active");
    userDataJson.removeWhere((key, value) => key == "is_suspended");
    userDataJson.removeWhere((key, value) => key == "profile_image");
    userDataJson.removeWhere((key, value) => key == "enrv");
    userDataJson.removeWhere((key, value) => key == "associated_business");
    userDataJson.removeWhere((key, value) => key == "details");

    var data = jsonEncode(userDataJson);

    try {
      final Response response = await dioClient.patch(
        Urls.RESET_NEW_PASSWORD,
        data: data,
      );

      // final response = await dio.post(
      //   Urls.RESET_NEW_PASSWORD,
      //   data: data,
      //   options: Options(
      //     contentType: "application/json",
      //   ),
      // );

      if (response.statusCode == 200) {
        // EmailVerifyCodeModel userData =
        //     EmailVerifyCodeModel.fromJson(response.data);

        // print(userData);

        return true;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
