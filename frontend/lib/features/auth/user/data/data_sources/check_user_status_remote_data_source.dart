import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

abstract class CheckUserStatusRemoteDataSource {
  Future<User> checkStatus(User data);
}

@Injectable(as: CheckUserStatusRemoteDataSource)
class GetUserDetailsListRemoteDataSourceImpl
    implements CheckUserStatusRemoteDataSource {
  @override
  Future<User> checkStatus(data) async {
    try {
      UserModel userModel =
          UserModel(is_active: data.is_active, is_suspended: data.is_suspended);

      var checkStatusInJson = userModel.toJson();

      checkStatusInJson.removeWhere((key, value) => value == null);
      checkStatusInJson.removeWhere((key, value) => key == "id");

      var userCheckStatus = jsonEncode(checkStatusInJson);

      final response = await dioClient.patch(Urls.USER_LIST + "${data.id!}/",
          data: userCheckStatus);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
