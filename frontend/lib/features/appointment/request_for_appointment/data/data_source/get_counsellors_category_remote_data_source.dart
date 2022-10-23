// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/model/category_counsellor_response_model.dart';

abstract class GetCounsellorsCategoryRemoteDataSource {
  Future<CategoryCounsellorResponseModel> getCounsellorsCategory(
      String subCategoryId);
}

@Injectable(as: GetCounsellorsCategoryRemoteDataSource)
class GetCounsellorsCategoryRemoteDataSourceImpl
    implements GetCounsellorsCategoryRemoteDataSource {
  Dio dio = Dio();
  @override
  Future<CategoryCounsellorResponseModel> getCounsellorsCategory(
      String subCategoryId) async {
    try {
      final response = await dio.get(
        Urls.getCounsellorCategory(subCategoryId),
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 200) {
        CategoryCounsellorResponseModel data =
            CategoryCounsellorResponseModel.fromJson(response.data);
        return data;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      // print(e.response);
      throw ServerException();
    }
  }
}
