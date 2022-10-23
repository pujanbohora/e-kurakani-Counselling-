// this is for api

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/verify_email_model.dart';

abstract class ForgetPasswordEmailVerificationRemoteDataSource {
  Future<bool> emailVerify(UserModel emailVerify);
}

@Injectable(as: ForgetPasswordEmailVerificationRemoteDataSource)
class ForgetPasswordEmailVerificationRemoteDataSourceImpl
    implements ForgetPasswordEmailVerificationRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<bool> emailVerify(UserModel emailVerify) async {
    EmailVerifyCodeModel emailVerifyModel =
        EmailVerifyCodeModel(email: emailVerify.email);

    var userEmailJson = emailVerifyModel.toJson();

    userEmailJson.removeWhere((key, value) => key == "message");
    userEmailJson.removeWhere((key, value) => key == "success");

    var data = jsonEncode(userEmailJson);

    try {
      final response = await dio.post(
        Urls.RESET_PASSWORD_EMAIL,
        data: data,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 200) {
        // UserModel userData =
        //     UserModel.fromJson(response.data);

        // print(response.data);

        // String userData = response.data;

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
