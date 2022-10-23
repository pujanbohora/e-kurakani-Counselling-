// this is for api

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/verify_email_model.dart';
import '../../domain/entities/email_verify.dart';

abstract class EmailVerificationRemoteDataSource {
  Future<EmailVerifyCodeModel> emailVerifyUser(EmailVerifyCode emailVerify);
}

@Injectable(as: EmailVerificationRemoteDataSource)
class EmailVerificationRemoteDataSourceImpl
    implements EmailVerificationRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<EmailVerifyCodeModel> emailVerifyUser(
      EmailVerifyCode emailVerify) async {
    EmailVerifyCodeModel emailVerifyCodeModel =
        EmailVerifyCodeModel(otp: emailVerify.otp, email: emailVerify.email);

    var userEmailJson = emailVerifyCodeModel.toJson();

    userEmailJson.removeWhere((key, value) => key == "message");
    userEmailJson.removeWhere((key, value) => key == "success");

    var data = jsonEncode(userEmailJson);

    try {
      final response = await dio.post(
        Urls.VERIFY_EMAIL_URL,
        data: data,
        options: Options(
          contentType: "application/json",
          // headers: <String, String>{
          //   'Authorization': 'Bearer abfb62c1-fbf7-4da5-98d0-04ff5e4f899d'
          // },
        ),
      );

      if (response.statusCode == 200) {
        EmailVerifyCodeModel userData =
            EmailVerifyCodeModel.fromJson(response.data);

        return userData;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
