import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/attachment_model.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/report/data/model/counsellor_feedback_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:injectable/injectable.dart';

abstract class CounsellorFeedbacRemotedataSource {
  Future<CounsellorFeedbackEntities> saveCounsellorFeedback(
      CounsellorFeedbackEntities data);
}

@Injectable(as: CounsellorFeedbacRemotedataSource)
class CounsellorFeedbacRemotedataSourceImpl
    implements CounsellorFeedbacRemotedataSource {
  @override
  Future<CounsellorFeedbackEntities> saveCounsellorFeedback(
      CounsellorFeedbackEntities data) async {
    CounsellorFeedbackModel cm = CounsellorFeedbackModel(
        // feedback_by: UserModel(id: data.id),
        feedback_for: data.feedback_for,
        star: data.star,
        message: data.message);

    print("this isisisisisiisisisiisisisissi");

    var counsellorFeedbackModelJson = cm.toJson();

    print(counsellorFeedbackModelJson);

    if (data.appointment == null) {
      counsellorFeedbackModelJson["counsellor"] = data.counsellor!.id;
    } else if (data.counsellor == null) {
      counsellorFeedbackModelJson["appointment"] = data.appointment!.id;
    }

    counsellorFeedbackModelJson["feedback_by"] = data.feedback_by!.id;

    var counsellorData = jsonEncode(counsellorFeedbackModelJson);

    try {
      final Response response = await dioClient.post(
        Urls.COUNSELLOR_FEEDBACK,
        data: counsellorData,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 201) {
        return CounsellorFeedbackEntities();
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
}
