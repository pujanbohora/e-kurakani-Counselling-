import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:frontend/core/error/exception.dart';

abstract class GetPastAppointmentRemoteSource {
  Future<List<UpcomingAppointmentResponseModel>> getPastAppointment();
}

@Injectable(as: GetPastAppointmentRemoteSource)
class GetPastAppointmentRemoteSourceImpl
    implements GetPastAppointmentRemoteSource {
  // Dio dio = Dio();
  @override
  Future<List<UpcomingAppointmentResponseModel>> getPastAppointment() async {
    final response = await dioClient.get(Urls.PAST_APPOINTMENTS);

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
}
