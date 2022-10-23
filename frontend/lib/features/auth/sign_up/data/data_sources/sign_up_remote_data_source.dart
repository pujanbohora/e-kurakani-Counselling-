// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> registerUser(User signUpData);

  Future<SignInResponseModel> loginWithPassword(User data);
}

@Injectable(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<UserModel> registerUser(User signUpData) async {
    UserModel userModel = UserModel(
        email: signUpData.email,
        user_role: signUpData.user_role,
        password: signUpData.password);

    var userDataInJson = userModel.toJson();
    userDataInJson.removeWhere((key, value) => key == "is_active");
    userDataInJson.removeWhere((key, value) => key == "is_suspended");
    var data = jsonEncode(userDataInJson);

    try {
      final response = await dio.post(
        Urls.REGISTER_URL,
        data: data,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 201) {
        UserModel userData = UserModel.fromJson(response.data);

        return userData;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<SignInResponseModel> loginWithPassword(User data) async {
    UserModel userModel = UserModel(
        id: data.id,
        email: data.email,
        password: data.password,
        user_role: data.user_role);

    var userDataInJson = userModel.toJson();

    var Userdata = jsonEncode(userDataInJson);

    try {
      final response = await dio.post(
        Urls.LOGIN_WITH_PASSWORD,
        data: Userdata,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 200) {
        // SignInResponseModel userDataResponse =
        //     SignInResponseModel.fromJson(response.data);

        // print(userDataResponse);
        SignInResponseModel userDataResponse =
            SignInResponseModel.fromJson(response.data);

        return userDataResponse;
      } else {
        return Future.error("User creation failed!");
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
