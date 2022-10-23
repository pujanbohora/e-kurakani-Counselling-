import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/utils/image_constants.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/core/zoom_app_credentials.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/domain/entity/appointment_meeting_entity.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/bloc/upcoming_appointment/upcoming_appointment_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:flutter_zoom_sdk/zoom_options.dart';
import 'package:flutter_zoom_sdk/zoom_view.dart';
import 'package:flutter/foundation.dart';

class AppointmentDetails extends StatefulWidget {
  final UpcomingAppointmentResponseModel? appointmentData;
  final UserModel? userData;
  AppointmentDetails({Key? key, this.appointmentData, this.userData})
      : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    print(widget.appointmentData);
    BlocProvider.of<UpcomingAppointmentBloc>(context)
        // .add(GetUpcomingAppointmentEvent());
        .add(GetUpcomingAppointmentDetailEvent(
            appointmentId: widget.appointmentData!.id!));
    super.initState();
  }

  late Timer timer;
  UpcomingAppointmentResponseModel? appointmentDetail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Scaffold(
    //   backgroundColor: const Color(0xffE4F2F7),
    //   appBar: appBar(
    //       noBackButton: false,
    //       navTitle: "Appointment Details",
    //       backNavigate: () {}),
    //   body: SingleChildScrollView(
    //     child: BlocBuilder<UpcomingAppointmentBloc, UpcomingAppointmentState>(builder: (context, state) {
    //       if (state is GetUpcomingAppointmentDetailLoadedState) {
    //         appointmentDetail = state.upcomingResponseData;
    //         return appointmentDetail != null ?
    //       }
    //     }),
    //   ),
    // );
    return BlocConsumer<UpcomingAppointmentBloc, UpcomingAppointmentState>(
      listener: (context, state) {
        if (state is GetUpcomingAppointmentDetailLoadedState) {
          appointmentDetail = state.upcomingResponseData;
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Request sucess!'),
          //   duration: Duration(seconds: 1),
          // ));
        } else if (state is GetUpcomingAppointmentDetailFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Request Failed!'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        if (state is GetUpcomingAppointmentDetailLoadingState) {
          return Scaffold(body: AppLoadingWidget());
        } else {
          return appointmentDetail != null
              ? Scaffold(
                  backgroundColor: const Color(0xffE4F2F7),
                  appBar: appBar(
                      noBackButton: false,
                      navTitle: "Appointment Details",
                      backNavigate: () {}),
                  body: SingleChildScrollView(
                    child: Container(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: Card(
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              widget.userData!.user_role == 'Counsellor' ||
                                      widget.userData!.user_role == 'Business'
                                  ? Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 15),
                                          child: Center(
                                            child: Text(
                                              "Requested Customer Detail",
                                              textScaleFactor: 1.3,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Wrap(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    appointmentDetail!.user!
                                                                .profile_image !=
                                                            null
                                                        ? NetworkImage(
                                                            appointmentDetail!
                                                                .user!
                                                                .profile_image!)
                                                        : const AssetImage(
                                                            "assets/images/counsellor_profile_image.jpeg",
                                                          ) as ImageProvider,
                                              ),
                                            ),
                                            FractionallySizedBox(
                                              // widthFactor: 0.6,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Name:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        appointmentDetail !=
                                                                null
                                                            ? appointmentDetail!
                                                                        .user!
                                                                        .details!
                                                                        .full_name !=
                                                                    null
                                                                ? appointmentDetail!
                                                                    .user!
                                                                    .details!
                                                                    .full_name!
                                                                : "N/A"
                                                            : "N/A",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'Phone no:',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        appointmentDetail !=
                                                                null
                                                            ? appointmentDetail!
                                                                        .user!
                                                                        .details!
                                                                        .contact_number !=
                                                                    null
                                                                ? appointmentDetail!
                                                                    .user!
                                                                    .details!
                                                                    .contact_number!
                                                                : "N/A"
                                                            : "N/A",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                      ],
                                    )
                                  : widget.userData!.user_role == 'Customer' ||
                                          widget.userData!.user_role ==
                                              'Business'
                                      ? Column(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 15),
                                              child: Center(
                                                child: Text(
                                                  "Counsellor Detail",
                                                  textScaleFactor: 1.3,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage: appointmentDetail!
                                                                .counsellor!
                                                                .user!
                                                                .profile_image !=
                                                            null
                                                        ? NetworkImage(
                                                            appointmentDetail!
                                                                .counsellor!
                                                                .user!
                                                                .profile_image!)
                                                        : const AssetImage(
                                                            "assets/images/counsellor_profile_image.jpeg",
                                                          ) as ImageProvider,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                FractionallySizedBox(
                                                  // widthFactor: 0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            "Name:",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            appointmentDetail !=
                                                                    null
                                                                ? appointmentDetail!
                                                                            .counsellor!
                                                                            .name !=
                                                                        null
                                                                    ? appointmentDetail!
                                                                        .counsellor!
                                                                        .name!
                                                                        .toUpperCase()
                                                                    : "N/A"
                                                                : "N/A",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            'Category:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            appointmentDetail !=
                                                                    null
                                                                ? appointmentDetail!
                                                                            .counsellor!
                                                                            .category !=
                                                                        null
                                                                    ? appointmentDetail!
                                                                        .counsellor!
                                                                        .category!
                                                                        .name!
                                                                    : "N/A"
                                                                : "N/A",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            'Phone no:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            appointmentDetail !=
                                                                    null
                                                                ? appointmentDetail!
                                                                            .counsellor!
                                                                            .contact_number !=
                                                                        null
                                                                    ? appointmentDetail!
                                                                        .counsellor!
                                                                        .contact_number!
                                                                    : "N/A"
                                                                : "N/A",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Meeting Details",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: appointmentDetail != null
                                      ? appointmentDetail!
                                                  .appointment_meeting !=
                                              null
                                          ? appointmentDetail!
                                                  .appointment_meeting!
                                                  .isNotEmpty
                                              ? List.generate(
                                                  appointmentDetail!
                                                      .appointment_meeting!
                                                      .length,
                                                  (index) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              "Duration",
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "${appointmentDetail!.appointment_meeting![index]!.zoom_meeting!.duration!} minutes",
                                                              textScaleFactor:
                                                                  1.2,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              "Meeting Status",
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              appointmentDetail!
                                                                  .appointment_meeting![
                                                                      index]!
                                                                  .status!
                                                                  .toUpperCase(),
                                                              textScaleFactor:
                                                                  1.2,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: const [
                                                            Text(
                                                              "Start Time",
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "${appointmentDetail!.appointment_meeting![index]!.start_time!.split("T")[0]} ${appointmentDetail!.appointment_meeting![index]!.start_time!.split("T")[1].replaceAll('Z', '')}",
                                                          textScaleFactor: 1.2,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        widget.userData!
                                                                    .user_role ==
                                                                'Customer'
                                                            ? ActionButton(
                                                                text:
                                                                    const Text(
                                                                  'Join Meeting',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onPressed: () {
                                                                  joinMeeting(
                                                                      context,
                                                                      appointmentDetail!
                                                                              .appointment_meeting![
                                                                          index]!);
                                                                },
                                                                background: Colors
                                                                    .lightBlue,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              )
                                                            : widget.userData!
                                                                        .user_role ==
                                                                    "Counsellor"
                                                                ? ActionButton(
                                                                    text:
                                                                        const Text(
                                                                      'Start Meeting',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      startMeetingNormal(
                                                                          context,
                                                                          appointmentDetail!
                                                                              .appointment_meeting![index]!);
                                                                    },
                                                                    background:
                                                                        Colors
                                                                            .lightBlue,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                  )
                                                                : const SizedBox(),
                                                      ],
                                                    );
                                                  },
                                                )
                                              : [
                                                  const Text(
                                                    "No Meeting",
                                                    textScaleFactor: 1.2,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ]
                                          : [
                                              const Text("N/A"),
                                            ]
                                      : [
                                          const Text("N/A"),
                                        ],
                                  // children: [
                                  //   Row(
                                  //     children: [
                                  //       const Text(
                                  //         "Duration",
                                  //         textScaleFactor: 1.2,
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   )
                                  // ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text('Fetching appointment detail...'),
                );
        }
      },
    );
  }

  joinMeeting(BuildContext context, AppointmentMeeting appointmentMeeting) {
    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid)
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      else
        result = status == "MEETING_STATUS_IDLE";

      return result;
    }

    if (appointmentMeeting.zoom_meeting_id != null &&
        appointmentMeeting.zoom_meeting!.password != null) {
      ZoomOptions zoomOptions = ZoomOptions(
        domain: "zoom.us",
        appKey: ZoomAppCredentials.APP_KEY, //API KEY FROM ZOOM - Sdk API Key
        appSecret: ZoomAppCredentials
            .SECRET_KEY, //API SECRET FROM ZOOM - Sdk API Secret
      );
      var meetingOptions = ZoomMeetingOptions(
          userId: widget.userData!
              .email!, //pass username for join meeting only --- Any name eg:- EVILRATT.
          meetingId: appointmentMeeting
              .zoom_meeting_id, //pass meeting id for join meeting only
          meetingPassword: appointmentMeeting.zoom_meeting!
              .password, //pass meeting password for join meeting only
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          disableTitlebar: "false",
          viewOptions: "true",
          noAudio: "false",
          noDisconnectAudio: "false");

      var zoom = ZoomView();
      zoom.initZoom(zoomOptions).then((results) {
        if (results[0] == 0) {
          zoom.onMeetingStatus().listen((status) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
            if (_isMeetingEnded(status[0])) {
              print("[Meeting Status] :- Ended");
              timer.cancel();
            }
          });
          print("listen on event channel");
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(new Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                print("[Meeting Status Polling] : " +
                    status[0] +
                    " - " +
                    status[1]);
              });
            });
          });
        }
      }).catchError((error) {
        print("[Error Generated] : " + error);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Meeting"),
        ),
      );
    }
  }

  startMeetingNormal(
      BuildContext context, AppointmentMeeting appointmentMeeting) {
    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid) {
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      } else {
        result = status == "MEETING_STATUS_IDLE";
      }

      return result;
    }

    ZoomOptions zoomOptions = ZoomOptions(
      domain: "zoom.us",
      appKey: ZoomAppCredentials.APP_KEY, //API KEY FROM ZOOM -- SDK KEY
      appSecret:
          ZoomAppCredentials.SECRET_KEY, //API SECRET FROM ZOOM -- SDK SECRET
    );
    var meetingOptions = ZoomMeetingOptions(
        userId: appointmentMeeting
            .zoom_meeting!.host_email, //pass host email for zoom
        userPassword:
            ZoomAppCredentials.HOST_PASSWORD, //pass host password for zoom
        meetingId: appointmentMeeting.zoom_meeting_id, //
        disableDialIn: "false",
        disableDrive: "false",
        disableInvite: "false",
        disableShare: "false",
        disableTitlebar: "false",
        viewOptions: "false",
        noAudio: "false",
        noDisconnectAudio: "false");

    var zoom = ZoomView();
    zoom.initZoom(zoomOptions).then((results) {
      if (results[0] == 0) {
        zoom.onMeetingStatus().listen((status) {
          if (kDebugMode) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
          }
          if (_isMeetingEnded(status[0])) {
            if (kDebugMode) {
              print("[Meeting Status] :- Ended");
            }
            timer.cancel();
          }
          if (status[0] == "MEETING_STATUS_INMEETING") {
            zoom.meetinDetails().then((meetingDetailsResult) {
              if (kDebugMode) {
                print("[MeetingDetailsResult] :- " +
                    meetingDetailsResult.toString());
              }
            });
          }
        });
        zoom.startMeetingNormal(meetingOptions).then((loginResult) {
          if (kDebugMode) {
            print("[LoginResult] :- " + loginResult.toString());
          }
          if (loginResult[0] == "SDK ERROR") {
            //SDK INIT FAILED
            if (kDebugMode) {
              print((loginResult[1]).toString());
            }
          } else if (loginResult[0] == "LOGIN ERROR") {
            //LOGIN FAILED - WITH ERROR CODES
            if (kDebugMode) {
              print((loginResult[1]).toString());
            }
          } else {
            //LOGIN SUCCESS & MEETING STARTED - WITH SUCCESS CODE 200
            if (kDebugMode) {
              print((loginResult[0]).toString());
            }
          }
        });
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("[Error Generated] : " + error);
      }
    });
  }
}
