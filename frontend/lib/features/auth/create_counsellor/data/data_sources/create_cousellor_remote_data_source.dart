// this is for api

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

abstract class CreateCounsellorRemoteDataSource {
  Future<UserModel> createCounsellor(User createCounsellor);

  // Future<SignInResponseModel> loginWithPassword(User data);
}

@Injectable(as: CreateCounsellorRemoteDataSource)
class CreateCounsellorRemoteDataSourceImpl
    implements CreateCounsellorRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<UserModel> createCounsellor(User signUpData) async {
    UserModel userModel = UserModel(
        email: signUpData.email,
        user_role: signUpData.user_role,
        password: signUpData.password,
        associated_business: signUpData.associated_business);

    var userDataInJson = userModel.toJson();
    userDataInJson.removeWhere((key, value) => key == "is_active");
    userDataInJson.removeWhere((key, value) => key == "is_suspended");
    var data = jsonEncode(userDataInJson);

    try {
      final response = await dio.post(
        Urls.USER_LIST,
        data: data,
        options: Options(
          contentType: "application/json",
        ),
      );
      if (response.statusCode == 200) {
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
}
