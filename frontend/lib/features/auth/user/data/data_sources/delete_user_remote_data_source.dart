import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteUserRemoteDataSource {
  Future<Map<String, dynamic>> deleteUser(User data);
}

@Injectable(as: DeleteUserRemoteDataSource)
class DeleteUserRemoteDataSourceImpl implements DeleteUserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> deleteUser(data) async {
    try {
      final response = await dioClient.delete(
        Urls.USER_LIST + "${data.id!}/",
      );

      if (response.statusCode == 204) {
        return {"success": "deleted"};
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
