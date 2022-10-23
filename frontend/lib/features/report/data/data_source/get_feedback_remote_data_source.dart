// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/features/report/data/model/counsellor_feedback_model.dart';
import 'package:frontend/features/report/data/model/report_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';

abstract class GetFeedbackRemotedataSource {
  Future<List<CounsellorFeedbackEntities>> getfeedback(String type);
}

@Injectable(as: GetFeedbackRemotedataSource)
class GetRportRemotedataSourceImpl implements GetFeedbackRemotedataSource {
  @override
  Future<List<CounsellorFeedbackEntities>> getfeedback(String type) async {
    try {
      print(Urls.COUNSELLOR_FEEDBACK + "?filter_by=$type");
      print("above is the url");
      final response = await dioClient.get(
        Urls.COUNSELLOR_FEEDBACK + "?filter_by=$type",
      );

      if (response.statusCode == 200) {
        List<CounsellorFeedbackModel> feedbackNames = [];

        print(
          "repoooooooorrttt",
        );
        for (final Map<String, dynamic> value in response.data) {
          print(value);
          CounsellorFeedbackModel md = CounsellorFeedbackModel.fromJson(value);
          feedbackNames.add(md);
        }

        print(
          "this is reports of hte user",
        );

        return feedbackNames;
      } else {
        return Future.error("Report submission failed!");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
