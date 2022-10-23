import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/appointment/past_appointments/presentation/bloc/past_appointment_bloc.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/bloc/upcoming_appointment/upcoming_appointment_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/report/data/model/counsellor_feedback_model.dart';
import 'package:frontend/features/report/data/model/report_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/presentation/bloc/feedback_bloc/counsellor_feedback_bloc.dart';
import 'package:frontend/features/report/presentation/bloc/report_bloc/report_bloc.dart';
import 'package:frontend/injectable.dart';
import 'package:rating_dialog/rating_dialog.dart';

class UserPastAppointmentScreen extends StatefulWidget {
  UserModel? userModel;
  UserPastAppointmentScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<UserPastAppointmentScreen> createState() =>
      _UserPastAppointmentScreenState();
}

class _UserPastAppointmentScreenState extends State<UserPastAppointmentScreen> {
  final approveSnackBar = SnackBar(
    content: const Text(
      'Hi, You have approved',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    backgroundColor: (Colors.white),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );

  void _showRatingDialog(String id) {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'How was your experience?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset("assets/images/LOGO.png"),
      submitButtonText: 'Submit',
      commentHint: 'Give us your feedback.',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        saveCounsellorFeedback(CounsellorFeedbackEntities(
            appointment: UpcomingAppointmentResponseModel(id: id),
            feedback_for: "appointment",
            star: response.rating,
            message: response.comment));
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  final TextEditingController _reportTitleController = TextEditingController();
  final TextEditingController _reportDesController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 300,
              height: 170,
              child: Column(children: [
                CustomTextField(
                  textController: _reportTitleController,
                  decoration: customFormFieldDecoration.copyWith(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    labelText: 'Title',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  // attribute: 'name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  maxLines: 4,
                  textController: _reportDesController,
                  decoration: customFormFieldDecoration.copyWith(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    labelText: 'Description',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  // attribute: 'name',
                ),
              ]),
            ),
            title: Text('Report'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () async {
                  print(id);
                  print("this is id happeno");

                  addReport(
                    ReportEntity(
                        // counsellor: CounsellorProfileModel(
                        //     id: widget.counsellorData!.id),
                        appointment: UpcomingAppointmentResponseModel(id: id),
                        report_for: 'appointment',
                        title: _reportTitleController.text,
                        description: _reportDesController.text),
                  );
                  // BlocProvider.of<ReportBloc>(context)
                  //     .add(AddCounsellorReportEvent(
                  //   reportEntity: ReportEntity(
                  //       // counsellor: CounsellorProfileModel(
                  //       //     id: widget.counsellorData!.id),
                  //       appointment: UpcomingAppointmentResponseModel(id: id),
                  //       report_for: 'appointment',
                  //       title: _reportTitleController.text,
                  //       description: _reportDesController.text),
                  // ));

                  _reportTitleController.clear();
                  _reportDesController.clear();

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    BlocProvider.of<PastAppointmentBloc>(context)
        .add(GetPastAppointmentEvent());
    super.initState();
  }

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: true,
          navTitle: "Past Appointments",
          backNavigate: () {}),
      // AppBar(
      //   title: Text('Appointments'),
      // ),
      body: SingleChildScrollView(
        child: BlocBuilder<PastAppointmentBloc, PastAppointmentState>(
          builder: (context, state) {
            if (state is GetUPastAppointmentLoadedState) {
              return state.pastResponseData.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: (size.height * 0.1)),
                      child: Column(
                        children: List.generate(
                          state.pastResponseData.length,
                          (index) {
                            return _buildAppointmentCard(
                              state.pastResponseData[index],
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(child: Text('No Appointments Found'));
            } else if (state is GetUpcomingAppointmentFailedState) {
              return const Center(
                child: Text('No Appointments Found'),
              );
            } else {
              return AppLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
      UpcomingAppointmentResponseModel appointmentData) {
    return GestureDetector(
      onTap: () async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        width: MediaQuery.of(context).size.width,
        child: Card(
          shadowColor: Colors.black,
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/counsellor_profile_image.jpeg"),
                ),
              ),
              Container(
                // width: double.infinity,
                // width: MediaQuery.of(context).size.width,
                // color: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.userModel!.user_role == 'Counsellor' ||
                                    widget.userModel!.user_role == 'Business'
                                ? appointmentData.user!.details != null
                                    ? appointmentData
                                                .user!.details!.full_name !=
                                            null
                                        ? appointmentData
                                            .user!.details!.full_name!
                                        : "N/A"
                                    : "N/A"
                                : widget.userModel!.user_role == 'Customer'
                                    ? appointmentData
                                                .counsellor!.user!.details !=
                                            null
                                        ? appointmentData.counsellor!.user!
                                                    .details!.full_name !=
                                                null
                                            ? appointmentData.counsellor!.user!
                                                .details!.full_name!
                                            : "N/A"
                                        : "N/A"
                                    : "N/A",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton(
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: InkWell(
                                        onTap: () {
                                          _showRatingDialog(
                                              appointmentData.id!);
                                        },
                                        child: const Text(
                                          'Feedback',
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: InkWell(
                                        onTap: () {
                                          _displayTextInputDialog(
                                              context, appointmentData.id!);
                                        },
                                        child: const Text(
                                          'Report',
                                        ),
                                      ),
                                    ),
                                  ])
                        ],
                      ),
                    ),
                    Text(
                      appointmentData.time != null
                          ? appointmentData.time!
                          : "N/A",
                    ),
                    Text(
                      appointmentData.date != null
                          ? appointmentData.date!
                          : "N/A",
                    ),
                    Text(
                      widget.userModel!.user_role == 'Counsellor' ||
                              widget.userModel!.user_role == 'Business'
                          ? appointmentData.user!.details != null
                              ? appointmentData.user!.details!.contact_number !=
                                      null
                                  ? appointmentData
                                      .user!.details!.contact_number!
                                  : "N/A"
                              : "N/A"
                          : widget.userModel!.user_role == 'Customer'
                              ? appointmentData.counsellor!.user!.details !=
                                      null
                                  ? appointmentData.counsellor!.user!.details!
                                              .contact_number !=
                                          null
                                      ? appointmentData.counsellor!.user!
                                          .details!.contact_number!
                                      : "N/A"
                                  : "N/A"
                              : "N/A",
                    ),
                    widget.userModel!.user_role == 'Business'
                        ? Text(
                            "Requested Counsellor: ${appointmentData.counsellor!.user!.details!.full_name}",
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ReportModel> addReport(ReportEntity data) async {
    print("this is AddReportRemotedataSourceImpl");

    UserModel? userInfo = await signUpLocalDataSource.getUserDataFromLocal();

    print(userInfo!.id);

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

    reportDataInJson["reported_by"] = userInfo.id;

    var reportData = jsonEncode(reportDataInJson);

    try {
      final response = await dioClient.post(
        Urls.REPORT,
        data: reportData,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Report sucess!'),
          duration: Duration(seconds: 1),
        ));
        return ReportModel();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error!'),
          duration: Duration(seconds: 1),
        ));
        return Future.error("Report submission failed!");
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<CounsellorFeedbackEntities> saveCounsellorFeedback(
      CounsellorFeedbackEntities data) async {
    // print(userInfo!.id);

    CounsellorFeedbackModel cm = CounsellorFeedbackModel(
        // feedback_by: UserModel(id: data.id),
        feedback_for: data.feedback_for,
        star: data.star,
        message: data.message);

    print("this isisisisisiisisisiisisisissi");

    var counsellorFeedbackModelJson = cm.toJson();

    print(counsellorFeedbackModelJson);
    print("this is data");

    if (data.appointment == null) {
      counsellorFeedbackModelJson["counsellor"] = data.counsellor!.id;
    } else if (data.counsellor == null) {
      counsellorFeedbackModelJson["appointment"] = data.appointment!.id;
    }

    UserModel? userInfo = await signUpLocalDataSource.getUserDataFromLocal();

    print("this is user id happeno ${userInfo!.id}");

    counsellorFeedbackModelJson["feedback_by"] = userInfo!.id;

    var counsellorData = jsonEncode(counsellorFeedbackModelJson);

    try {
      final Response response = await dioClient.post(
        Urls.COUNSELLOR_FEEDBACK,
        data: counsellorData,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Appointment feedback sucess!'),
          duration: Duration(seconds: 1),
        ));
        return CounsellorFeedbackEntities();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error!'),
          duration: Duration(seconds: 1),
        ));
        return Future.error("Application process failed!");
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
