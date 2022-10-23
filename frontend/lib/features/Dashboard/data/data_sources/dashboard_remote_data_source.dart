import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/Dashboard/data/model/business_dashboard_response_model.dart';
import 'package:frontend/features/Dashboard/data/model/counsellor_dashboard_response_model.dart';
import 'package:frontend/features/Dashboard/data/model/customer_dashboard_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class DashboardRemoteDataSource {
  Future<CustomerDashboardResponseModel> getCustomerDashboard();
  Future<BusinessDashboardResponseModel> getBusinessDashboard();
  Future<CounsellorDashboardResponseModel> getCounsellorDashboard();
}

@Injectable(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<CustomerDashboardResponseModel> getCustomerDashboard() async {
    try {
      final response = await dioClient.get(
        Urls.DASHBOARD_URL,
      );
      if (response.statusCode == 200) {
        CustomerDashboardResponseModel cdrm =
            CustomerDashboardResponseModel.fromJson(response.data);
        return cdrm;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<BusinessDashboardResponseModel> getBusinessDashboard() async {
    try {
      final response = await dioClient.get(
        Urls.DASHBOARD_URL,
      );
      if (response.statusCode == 200) {
        BusinessDashboardResponseModel bdrm =
            BusinessDashboardResponseModel.fromJson(response.data);
        return bdrm;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CounsellorDashboardResponseModel> getCounsellorDashboard() async {
    try {
      final response = await dioClient.get(
        Urls.DASHBOARD_URL,
      );
      if (response.statusCode == 200) {
        CounsellorDashboardResponseModel cdrm =
            CounsellorDashboardResponseModel.fromJson(response.data);
        return cdrm;
      } else {
        return Future.error("User Get Failed");
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
