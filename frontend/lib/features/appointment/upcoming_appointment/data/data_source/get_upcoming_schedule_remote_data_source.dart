import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:frontend/core/error/exception.dart';

abstract class GetUpcomingAppointmentRemoteSource {
  Future<List<UpcomingAppointmentResponseModel>> getUpcomingAppointment();
  Future<List<UpcomingAppointmentResponseModel>>
      getCustomerUpcomingAppointment();
  Future<UpcomingAppointmentResponseModel> getUpcomingAppointmentDetail(
      String appointmentId);
}

@Injectable(as: GetUpcomingAppointmentRemoteSource)
class GetUpcomingAppointmentRemoteSourceImpl
    implements GetUpcomingAppointmentRemoteSource {
  // Dio dio = Dio();
  @override
  Future<List<UpcomingAppointmentResponseModel>>
      getUpcomingAppointment() async {
    final response = await dioClient.get(Urls.GET_COUNSELLOR_APPOINTMENTS);

    try {
      if (response.statusCode == 200) {
        List<UpcomingAppointmentResponseModel> upcomingAppointmentResponse = [];
        for (final Map<String, dynamic> value in response.data) {
          UpcomingAppointmentResponseModel md =
              UpcomingAppointmentResponseModel.fromJson(value);
          upcomingAppointmentResponse.add(md);
        }
        return upcomingAppointmentResponse;
      } else {
        return Future.error("Upcoming Appointment Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<UpcomingAppointmentResponseModel>>
      getCustomerUpcomingAppointment() async {
    final response = await dioClient.get(Urls.UPCOMING_APPOINTMENTS);

    try {
      if (response.statusCode == 200) {
        List<UpcomingAppointmentResponseModel> upcomingAppointmentResponse = [];
        for (final Map<String, dynamic> value in response.data) {
          UpcomingAppointmentResponseModel md =
              UpcomingAppointmentResponseModel.fromJson(value);
          upcomingAppointmentResponse.add(md);
        }
        return upcomingAppointmentResponse;
      } else {
        return Future.error("Upcoming Appointment Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<UpcomingAppointmentResponseModel> getUpcomingAppointmentDetail(
      String appointmentId) async {
    final response =
        await dioClient.get(Urls.getAppointmentDetail(appointmentId));

    try {
      if (response.statusCode == 200) {
        UpcomingAppointmentResponseModel upcomingAppointmentResponse =
            UpcomingAppointmentResponseModel.fromJson(response.data);

        return upcomingAppointmentResponse;
      } else {
        return Future.error("Upcoming Appointment Get Failed");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
