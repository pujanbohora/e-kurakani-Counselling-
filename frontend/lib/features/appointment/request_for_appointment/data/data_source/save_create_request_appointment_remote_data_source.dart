// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/appointment/request_for_appointment/data/model/create_request_model.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';

abstract class SaveCreateRequestAppointmentRemoteDataSource {
  Future<CreateRequestEntiry> saveCreateRequestAppointment(
      CreateRequestEntiry data);
}

@Injectable(as: SaveCreateRequestAppointmentRemoteDataSource)
class SaveCreateRequestAppointmentRemoteDataSourceImpl
    implements SaveCreateRequestAppointmentRemoteDataSource {
  Dio dio = Dio();
  @override
  Future<CreateRequestEntiry> saveCreateRequestAppointment(
      CreateRequestEntiry data) async {
    CreateRequestModel createRequestModel = CreateRequestModel(
      date: data.date,
      time: data.time,
      counsellor: data.counsellor,
      user: data.user,
      // remarks: data.remarks,
    );

    var createRequestInJson = createRequestModel.toJson();
    var saveCreateRequestData = jsonEncode(createRequestInJson);

    try {
      final response = await dio.post(
        Urls.PAYMENT_WITH_CREATE_APPOINTMENT +
            "?token=${data.token}&amount=${data.amount}",
        data: saveCreateRequestData,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 200) {
        // CreateRequestModel data = CreateRequestModel.fromJson(response.data);

        return data;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
