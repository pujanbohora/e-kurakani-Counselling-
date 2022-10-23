import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:injectable/injectable.dart';

abstract class GetBusinessProfileRemotedataSource {
  Future<BusinessProfile> getBusiness(String userId);
  Future<List<BusinessProfile>> getBusinessProfileRequests();
}

@Injectable(as: GetBusinessProfileRemotedataSource)
class GetBusinessProfileRemotedataSourceImpl
    implements GetBusinessProfileRemotedataSource {
  Dio dio = Dio();

  @override
  Future<BusinessProfile> getBusiness(String userId) async {
    try {
      final response = await dio.get(Urls.getBusinessProfile(userId));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);

        BusinessProfileModel profileData =
            BusinessProfileModel.fromJson(response.data);
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
  Future<List<BusinessProfile>> getBusinessProfileRequests() async {
    try {
      final response = await dio.get(Urls.BUSINESS_PROFILE_REQUESTS);

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);

        List<BusinessProfileModel> businessProfileRequests = [];
        for (final Map<String, dynamic> value in response.data) {
          BusinessProfileModel md = BusinessProfileModel.fromJson(value);
          businessProfileRequests.add(md);
        }
        return businessProfileRequests;
      } else {
        return Future.error("Profile Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
