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

abstract class EditUserProfileRemoteDataSource {
  Future<UserDetails> editUserProfile(UserDetails userData);
}

@Injectable(as: EditUserProfileRemoteDataSource)
class EditUserProfileRemoteDataSourceImpl
    implements EditUserProfileRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<UserDetails> editUserProfile(userData) async {
    try {
      print("inside the remote data source");
      // String fileName = userData.fileData!.path.split('/').last;

      print(userData);
      FormData formData = FormData.fromMap({
        "full_name": userData.full_name,
        "contact_number": userData.contact_number,
        "bio": userData.bio
      });
      if (userData.fileData != null) {
        formData.files.add(
          MapEntry(
            'profile_image',
            await MultipartFile.fromFile(
              userData.fileData!.path,
              filename: userData.fileData!.path,
            ),
          ),
        );
      }

      final response = await dioClient
          .patch("${Urls.EDIT_USER_ACCOUNT}${userData.id!}/", data: formData);

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
