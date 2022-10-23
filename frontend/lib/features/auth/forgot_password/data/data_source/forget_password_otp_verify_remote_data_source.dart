// this is for api

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/verify_email_model.dart';

abstract class ForgetPasswordOTPVerifyRemoteDataSource {
  Future<String> otpVerify(EmailVerifyCode emailVerify);
}

@Injectable(as: ForgetPasswordOTPVerifyRemoteDataSource)
class ForgetPasswordOTPVerifyRemoteDataSourceImpl
    implements ForgetPasswordOTPVerifyRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<String> otpVerify(EmailVerifyCode emailVerify) async {
    EmailVerifyCodeModel emailVerifyCodeModel =
        EmailVerifyCodeModel(otp: emailVerify.otp, email: emailVerify.email);

    var userEmailJson = emailVerifyCodeModel.toJson();

    userEmailJson.removeWhere((key, value) => key == "message");
    userEmailJson.removeWhere((key, value) => key == "success");

    var data = jsonEncode(userEmailJson);

    // print()

    try {
      final response = await dio.post(
        Urls.RESET_PASSWORD_OTP,
        data: data,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 200) {
        // EmailVerifyCodeModel userData =
        //     EmailVerifyCodeModel.fromJson(response.data);

        // print(userData);

        return response.data["otp"];
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
