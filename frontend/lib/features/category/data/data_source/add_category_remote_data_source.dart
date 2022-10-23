// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

abstract class AddCategoryRemotedataSource {
  Future<AddCategoryModel> addCategory(AddCategoryEntity data);
}

@Injectable(as: AddCategoryRemotedataSource)
class AddCategoryRemotedataSourceImpl implements AddCategoryRemotedataSource {
  Dio dio = Dio();
  @override
  Future<AddCategoryModel> addCategory(AddCategoryEntity data) async {
    FormData formData = FormData.fromMap({
      "name": data.name,
      "parent": data.parent,
      "image": MultipartFile.fromFileSync(
        data.imageData!.path,
        filename: data.imageData!.path.split('/').last,
      )
    });
    AddCategoryModel addCategoryModel =
        AddCategoryModel(name: data.name, parent: data.parent);

    var addCategoryDataInJson = addCategoryModel.toJson();
    addCategoryDataInJson.removeWhere((key, value) => key == "id");
    addCategoryDataInJson.removeWhere((key, value) => key == "parent");
    var addCategoryData = jsonEncode(addCategoryDataInJson);

    try {
      final response = await dio.post(
        Urls.ADD_CATEGORY,
        data: formData,
      );
      print(response.data);

      if (response.statusCode == 201) {
        print("nice job");
        return AddCategoryModel();
      } else {
        return Future.error("User creation failed!");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
