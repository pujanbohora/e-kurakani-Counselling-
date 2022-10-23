import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_detail_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';
import 'package:injectable/injectable.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<UserDetails> changePassword(
      String new_password, String old_password, String id);
}

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<UserDetails> changePassword(new_password, old_password, id) async {
    try {
      print("inside the remote data source");
      // String fileName = userData.fileData!.path.split('/').last;

      // UserModel userModel = UserModel(password: );

      print(new_password);
      print(old_password);
      print(id);

      final response = await dioClient.patch(Urls.CHAGNE_PASSWORD,
          data: {"old_password": old_password, "new_password": new_password});

      if (response.statusCode == 200) {
        print(response.data);

        UserDetailsModel userData = UserDetailsModel.fromJson(response.data);

        return userData;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
