import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteCategoryRemoteDataSource {
  Future<Map<String, dynamic>> deleteCategory(String id);
}

@Injectable(as: DeleteCategoryRemoteDataSource)
class DeleteCategoryRemoteDataSourceImpl
    implements DeleteCategoryRemoteDataSource {
  @override
  Future<Map<String, dynamic>> deleteCategory(id) async {
    try {
      print(Urls.DELETE_CATEGORY + id);

      final response = await dioClient.delete(
        Urls.DELETE_CATEGORY + "${id}/",
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
