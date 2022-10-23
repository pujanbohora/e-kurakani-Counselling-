import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserProfileRemoteDataSource {
  Future<User> getUserProfile(String id);
}

@Injectable(as: GetUserProfileRemoteDataSource)
class GetUserProfileRemoteDataSourceImpl
    implements GetUserProfileRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<User> getUserProfile(id) async {
    try {
      print(Urls.GET_USER_ACCOUNT + id);
      final response = await dioClient.get('${Urls.GET_USER_ACCOUNT}$id/');

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("inside the GET_USER_ACCOUNT");
        print(response.data);
        UserModel userData = UserModel.fromJson(response.data);

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
