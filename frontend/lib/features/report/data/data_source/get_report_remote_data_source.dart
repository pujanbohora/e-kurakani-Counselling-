// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/features/report/data/model/report_model.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';

abstract class GetReportRemotedataSource {
  Future<List<ReportModel>> getReport(String type);
}

@Injectable(as: GetReportRemotedataSource)
class GeteportRemotedataSourceImpl implements GetReportRemotedataSource {
  @override
  Future<List<ReportModel>> getReport(String type) async {
    try {
      print(Urls.REPORT + "?filter_by=$type");
      print("above is the url");
      final response = await dioClient.get(
        Urls.REPORT + "?filter_by=$type",
      );

      if (response.statusCode == 200) {
        List<ReportModel> reportNames = [];

        print(
          "repoooooooorrttt",
        );
        for (final Map<String, dynamic> value in response.data) {
          print(value);
          ReportModel md = ReportModel.fromJson(value);
          reportNames.add(md);
        }

        print(
          "this is reports of hte user",
        );

        return reportNames;
      } else {
        return Future.error("Report submission failed!");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
