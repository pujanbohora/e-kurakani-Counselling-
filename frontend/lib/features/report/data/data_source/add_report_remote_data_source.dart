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

abstract class AddReportRemotedataSource {
  Future<ReportModel> addReport(ReportEntity data);
}

@Injectable(as: AddReportRemotedataSource)
class AddReportRemotedataSourceImpl implements AddReportRemotedataSource {
  @override
  Future<ReportModel> addReport(ReportEntity data) async {

    print("this is AddReportRemotedataSourceImpl");
    ReportModel rm = ReportModel(
        title: data.title,
        description: data.description,
        report_for: data.report_for);

    var reportDataInJson = rm.toJson();

    print(reportDataInJson);

    if (data.appointment == null) {
      reportDataInJson["counsellor"] = data.counsellor!.id;
    } else if (data.counsellor == null) {
      reportDataInJson["appointment"] = data.appointment!.id;
    }

    reportDataInJson["reported_by"] = data.reported_by!.id;

    var reportData = jsonEncode(reportDataInJson);

    print(" this is report data $reportData");

    try {

      print("this is report data happeno hahhah");
      final response = await dioClient.post(
        Urls.REPORT,
        data: reportData,
      );

      if (response.statusCode == 201) {
        return ReportModel();
      } else {
        return Future.error("Report submission failed!");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }


}
