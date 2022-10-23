// this is for api

// Dart imports:

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/features/Schedule/data/model/schedule_week_model.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:injectable/injectable.dart';

// Project imports:

abstract class GetScheduleListRemoteDataSource {
  Future<List<ScheduleWeekEntities>> getSheduleList();
  Future<Map<String, dynamic>> deleteSchedule(id);
}

@Injectable(as: GetScheduleListRemoteDataSource)
class EmailVerificationRemoteDataSourceImpl
    implements GetScheduleListRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<List<ScheduleWeekEntities>> getSheduleList() async {
    try {
      final response = await dioClient.get(Urls.GET_SCHEDULE_LIST);
      if (response.statusCode == 200) {
        List<ScheduleWeekModel> getScheduleWeekModel = [];

        for (final Map<String, dynamic> value in response.data) {
          ScheduleWeekModel md = ScheduleWeekModel.fromJson(value);
          getScheduleWeekModel.add(md);
        }
        return getScheduleWeekModel;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> deleteSchedule(id) async {
    try {
      final response = await dioClient.delete(
        "${Urls.ADD_SCHEDULE_URL}$id/",
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
