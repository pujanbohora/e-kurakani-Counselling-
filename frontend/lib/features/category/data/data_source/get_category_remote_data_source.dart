// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';

abstract class GetCategoryRemotedataSource {
  Future<List<AddCategoryModel>> getCategory();
  Future<List<AddCategoryModel>> getSubCategory();
}

@Injectable(as: GetCategoryRemotedataSource)
class AddCategoryRemotedataSourceImpl implements GetCategoryRemotedataSource {
  Dio dio = Dio();

  @override
  Future<List<AddCategoryModel>> getCategory() async {
    try {
      final response = await dio.get(Urls.GET_CATEGORY);
      if (response.statusCode == 200) {
        List<AddCategoryModel> categoryNames = [];
        for (final Map<String, dynamic> value in response.data) {
          AddCategoryModel md = AddCategoryModel.fromJson(value);
          categoryNames.add(md);
        }

        print(categoryNames);
        return categoryNames;

        // return userData;
      } else {
        return Future.error("Category Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<AddCategoryModel>> getSubCategory() async {
    try {
      final response = await dio.get(Urls.GET_SUB_CATEGORY);
      if (response.statusCode == 200) {
        List<AddCategoryModel> categoryNames = [];
        for (final Map<String, dynamic> value in response.data) {
          AddCategoryModel md = AddCategoryModel.fromJson(value);
          categoryNames.add(md);
        }
        return categoryNames;

        // return userData;
      } else {
        return Future.error("Category Get Failed");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
