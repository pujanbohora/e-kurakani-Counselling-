import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/data/model/timetable_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:injectable/injectable.dart';

abstract class ApplyCounsellorProfileRemotedataSource {
  Future<CounsellorProfileModel> applyVerification(CounsellorProfile data);
  Future<CounsellorProfileModel> editCounsellorProfile(CounsellorProfile data);
  Future<CounsellorProfileModel> changeStatus(CounsellorProfile data);
  Future<Map<String, dynamic>> addTimeTable(CounsellorTimeTable data);
  Future<bool> addSchedule(CounsellorTimeTable data);
  Future<Map<String, dynamic>> deleteCounsellorAttachment(id);
}

@Injectable(as: ApplyCounsellorProfileRemotedataSource)
class ApplyCounsellorProfileRemotedataSourceImpl
    implements ApplyCounsellorProfileRemotedataSource {
  // DioClient dioClient = DioClient(
  //   baseUrl: Urls.BASE_URL,
  //   dio: Dio(),
  //   interceptors: [EKurakaniInterceptor(const FlutterSecureStorage())],
  // );
  // Dio dio = Dio();
  @override
  Future<CounsellorProfileModel> applyVerification(
      CounsellorProfile data) async {
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
      "time_interval": data.time_interval,
      "price": data.price,
      "category": data.category!.id,
    });

    try {
      final Response response = await dioClient.patch(
        Urls.updateCounsellorApplication(data.id!),
        data: formData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'is_freelancer');
        response.data.removeWhere((key, value) => key == 'user');
        response.data.removeWhere((key, value) => key == 'category');
        response.data.removeWhere((key, value) => key == 'associated_business');
        return CounsellorProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<CounsellorProfileModel> changeStatus(CounsellorProfile data) async {
    CounsellorProfileModel counsellorProfileModel = CounsellorProfileModel(
        id: data.id, status: data.status, remarks: data.remarks);
    print("ApplyCounsellorProfileRemotedataSourceImpl");

    print(counsellorProfileModel);

    var profileDatainJson = counsellorProfileModel.toJson();
    profileDatainJson.removeWhere((key, value) => value == null);
    profileDatainJson.removeWhere((key, value) => key == 'id');

    var profileData = jsonEncode(profileDatainJson);

    try {
      final Response response = await dioClient.patch(
        Urls.updateCounsellorApplication(data.id!),
        data: profileData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'is_freelancer');
        response.data.removeWhere((key, value) => key == 'user');
        response.data.removeWhere((key, value) => key == 'category');
        response.data.removeWhere((key, value) => key == 'associated_business');
        return CounsellorProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> addTimeTable(CounsellorTimeTable data) async {
    TimeTableModel timeTableModel = TimeTableModel(
      month: data.month,
      start_time: data.start_time,
      end_time: data.end_time,
    );
    print(data);

    var timeTableDatainJson = timeTableModel.toJson();
    timeTableDatainJson["counsellor"] = data.counsellor!.id;
    var timeTableData = jsonEncode(timeTableDatainJson);

    try {
      final Response response = await dioClient.post(
        Urls.ADD_MONTH_TIMETABLE_URL,
        data: timeTableData,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        return Future.error("Timetable cration process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<bool> addSchedule(CounsellorTimeTable data) async {
    TimeTableModel timeTableModel = TimeTableModel(
      date: data.date,
      start_time: data.start_time,
      end_time: data.end_time,
    );

    var timeTableDatainJson = timeTableModel.toJson();
    timeTableDatainJson["counsellor"] = data.counsellor!.id;
    var timeTableData = jsonEncode(timeTableDatainJson);

    try {
      final Response response = await dioClient.post(
        Urls.ADD_SCHEDULE_URL,
        data: timeTableData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return Future.error("Schedule cration process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<CounsellorProfileModel> editCounsellorProfile(
      CounsellorProfile data) async {
    FormData formData = FormData.fromMap({
      "id": data.id,
      "name": data.name,
      "email": data.email,
      "contact_number": data.contact_number,
      "time_interval": data.time_interval,
      "price": data.price,
      "category": data.category!.id,
    });

    try {
      final Response response = await dioClient.patch(
        Urls.updateCounsellorApplication(data.id!),
        data: formData,
      );

      if (response.statusCode == 200) {
        response.data.removeWhere((key, value) => key == 'status');
        response.data.removeWhere((key, value) => key == 'is_freelancer');
        response.data.removeWhere((key, value) => key == 'user');
        response.data.removeWhere((key, value) => key == 'category');
        response.data.removeWhere((key, value) => key == 'associated_business');
        return CounsellorProfileModel.fromJson(response.data);
      } else {
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> deleteCounsellorAttachment(id) async {
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
