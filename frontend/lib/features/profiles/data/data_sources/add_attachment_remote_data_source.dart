import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/data/model/timetable_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:injectable/injectable.dart';

abstract class AttachmentRemotedataSource {
  Future<AttachmentModel> addCounsellorAttachment(ProfileAttachments data);
  Future<AttachmentModel> addBusinessAttachment(ProfileAttachments data);
  Future<AttachmentModel> updateCounsellorAttachment(ProfileAttachments data);
}

@Injectable(as: AttachmentRemotedataSource)
class AttachmentRemotedataSourceImpl implements AttachmentRemotedataSource {
  // DioClient dioClient = DioClient(
  //   baseUrl: Urls.BASE_URL,
  //   dio: Dio(),
  //   interceptors: [EKurakaniInterceptor(const FlutterSecureStorage())],
  // );
  // Dio dio = Dio();
  @override
  Future<AttachmentModel> addCounsellorAttachment(
      ProfileAttachments data) async {
    String fileName = data.fileData!.path.split('/').last;
    print(data);
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(data.fileData!.path, filename: fileName),
      "label": data.label,
      "remarks": data.remarks,
    });
    print(formData);
    try {
      final Response response = await dioClient.post(
        Urls.addCounsellorAttachments(data.counsellor_profile!.id!),
        data: formData,
      );

      if (response.statusCode == 201) {
        response.data.removeWhere((key, value) => key == 'counsellor_profile');
        response.data.removeWhere((key, value) => key == 'business_profile');
        return AttachmentModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<AttachmentModel> updateCounsellorAttachment(
      ProfileAttachments data) async {
    String fileName = data.fileData!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(data.fileData!.path, filename: fileName),
      "label": data.label,
      "remarks": data.remarks,
    });

    try {
      final Response response = await dioClient.post(
        Urls.updateCounsellorAttachments(
            data.counsellor_profile!.id!, data.id!),
        data: formData,
      );

      if (response.statusCode == 200) {
        return AttachmentModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<AttachmentModel> addBusinessAttachment(ProfileAttachments data) async {
    String fileName = data.fileData!.path.split('/').last;
    print(data);
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(data.fileData!.path, filename: fileName),
      "label": data.label,
      "remarks": data.remarks,
    });
    print(formData);
    try {
      final Response response = await dioClient.post(
        Urls.addBusinessAttachments(data.business_profile!.id!),
        data: formData,
      );

      if (response.statusCode == 201) {
        response.data.removeWhere((key, value) => key == 'counsellor_profile');
        response.data.removeWhere((key, value) => key == 'business_profile');
        return AttachmentModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
