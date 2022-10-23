import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:injectable/injectable.dart';

abstract class GetCounsellorProfileRemotedataSource {
  Future<CounsellorProfile> getCounsellor(String userId);
  Future<List<CounsellorProfile>> getCounsellorProfileRequests();
}

@Injectable(as: GetCounsellorProfileRemotedataSource)
class GetCounsellorProfileRemotedataSourceImpl
    implements GetCounsellorProfileRemotedataSource {
  Dio dio = Dio();

  @override
  Future<CounsellorProfile> getCounsellor(String userId) async {
    print("Inside repo: $userId");
    try {
      final response = await dio.get(Urls.getCounsellorProfile(userId));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);

        CounsellorProfileModel profileData =
            CounsellorProfileModel.fromJson(response.data);
        print("HEHEHEH");
        return profileData;
      } else {
        return Future.error("Profile Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<CounsellorProfile>> getCounsellorProfileRequests() async {
    try {
      final response = await dio.get(Urls.COUNSELLOR_PROFILE_REQUESTS);

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);

        List<CounsellorProfileModel> counsellorProfileRequests = [];
        for (final Map<String, dynamic> value in response.data) {
          CounsellorProfileModel md = CounsellorProfileModel.fromJson(value);
          counsellorProfileRequests.add(md);
        }
        return counsellorProfileRequests;
      } else {
        return Future.error("Profile Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
