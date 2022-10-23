import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserDetailsListRemoteDataSource {
  Future<List<User>> getUserDetailsList();
}

@Injectable(as: GetUserDetailsListRemoteDataSource)
class GetUserDetailsListRemoteDataSourceImpl
    implements GetUserDetailsListRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<List<User>> getUserDetailsList() async {
    try {
      final response = await dioClient.get(Urls.USER_LIST);

      if (response.statusCode == 200) {
        List<User> userDetailsData = [];

        for (final Map<String, dynamic> value in response.data) {
          UserModel data = UserModel.fromJson(value);
          userDetailsData.add(data);
        }
        return userDetailsData;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
