import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:injectable/injectable.dart';

abstract class ApplyBusinessProfileRemotedataSource {
  Future<BusinessProfileModel> applyVerification(BusinessProfile data);
  Future<BusinessProfileModel> changeStatus(BusinessProfile data);
  Future<BusinessProfileModel> editBusinessProfile(BusinessProfile data);
  Future<Map<String, dynamic>> deleteBusinessAttachment(id);
}

@Injectable(as: ApplyBusinessProfileRemotedataSource)
class ApplyBusinessProfileRemotedataSourceImpl
    implements ApplyBusinessProfileRemotedataSource {
  // DioClient dioClient = DioClient(
  //   baseUrl: Urls.BASE_URL,
  //   dio: Dio(),
  //   interceptors: [EKurakaniInterceptor(const FlutterSecureStorage())],
  // );
  // Dio dio = Dio();
  @override
  Future<BusinessProfileModel> applyVerification(BusinessProfile data) async {
    print("Let's go");
    print(data.category!.id);

    FormData formData = FormData.fromMap({
      "files": data.profile_attachments!
          .map((item) => MultipartFile.fromFileSync(
                item.fileData!.path,
                filename: item.fileData!.path.split('/').last,
              ))
          .toList(),
      "attachments": data.profile_attachments!
          .map(
            (attData) => json.encode({
              "label": attData.label,
              "remarks": attData.remarks,
            }),
          )
          .toList(),
      "id": data.id,
      "name": data.name,
      "email": data.email,
      "contact_number": data.contact_number,
      "apply_for_verification": true,
      "category": data.category!.id,
      "logo": MultipartFile.fromFileSync(
        data.logoData!.path,
        filename: data.logoData!.path.split('/').last,
      )
    });

    try {
      final Response response = await dioClient.patch(
        Urls.updateBusinessApplication(data.id!),
        data: formData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'category');
        response.data.removeWhere((key, value) => key == 'user');
        return BusinessProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<BusinessProfileModel> changeStatus(BusinessProfile data) async {
    BusinessProfileModel businessProfileModel = BusinessProfileModel(
        id: data.id, status: data.status, remarks: data.remarks);

    var profileDatainJson = businessProfileModel.toJson();
    profileDatainJson.removeWhere((key, value) => value == null);
    profileDatainJson.removeWhere((key, value) => key == 'id');

    var profileData = jsonEncode(profileDatainJson);

    try {
      final Response response = await dioClient.patch(
        Urls.updateBusinessApplication(data.id!),
        data: profileData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'user');
        response.data.removeWhere((key, value) => key == 'category');
        return BusinessProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<BusinessProfileModel> editBusinessProfile(BusinessProfile data) async {
    FormData formData = FormData.fromMap({
      "id": data.id,
      "name": data.name,
      "email": data.email,
      "contact_number": data.contact_number,
      "category": data.category!.id,
    });
    if (data.logoData != null) {
      formData.files.add(
        MapEntry(
          'logo',
          MultipartFile.fromFileSync(
            data.logoData!.path,
            filename: data.logoData!.path.split('/').last,
          ),
        ),
      );
    }

    try {
      final Response response = await dioClient.patch(
        Urls.updateBusinessApplication(data.id!),
        data: formData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'user');
        response.data.removeWhere((key, value) => key == 'category');
        return BusinessProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> deleteBusinessAttachment(id) async {
    try {
      final response = await dioClient.delete(
        Urls.profileAttachmentUrl(id),
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
