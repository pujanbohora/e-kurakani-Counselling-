import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/report/presentation/bloc/feedback_bloc/counsellor_feedback_bloc.dart';
import 'package:frontend/features/report/presentation/bloc/report_bloc/report_bloc.dart';

import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/profiles/presentation/bloc/profile_request/profile_request_bloc.dart';

class FeedbackViewScreen extends StatefulWidget {
  const FeedbackViewScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackViewScreen> createState() => _FeedbackViewScreenState();
}

class _FeedbackViewScreenState extends State<FeedbackViewScreen> {
  @override
  void initState() {
    BlocProvider.of<CounsellorFeedbackBloc>(context)
        .add(GetFeedbackAppointmentEvent(type: "counsellor"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: true, navTitle: "Feedbacks", backNavigate: () {}),
      //  AppBar(
      //   title: const Text("Display Profile Request"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: (size.height * 0.1), left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                        background: CustomColors.black,
                        width: size.width,
                        height: 40,
                        borderRadius: 10,
                        text: Text(
                          "Counsellors",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<CounsellorFeedbackBloc>(context).add(
                              GetFeedbackAppointmentEvent(type: "counsellor"));
                        }),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ActionButton(
                        background: CustomColors.black,
                        width: size.width,
                        height: 40,
                        borderRadius: 10,
                        text: Text(
                          "Appointments",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<CounsellorFeedbackBloc>(context).add(
                              GetFeedbackAppointmentEvent(type: "appointment"));
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: double.infinity,
                child: BlocBuilder<CounsellorFeedbackBloc,
                    CounsellorFeedbackState>(
                  builder: (context, feedbackState) {
                    if (feedbackState is GetFeedbackLoadedState) {
                      return _buildAppointmentbody(context, feedbackState);
                    } else if (feedbackState
                        is GetFeedbackAppointmentFailedState) {
                      return const Center(
                        child: Text("Couldn't fetch appointment feedback"),
                      );
                    } else {
                      return AppLoadingWidget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentbody(context, feedbackState) {
    return feedbackState.reportEntity.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: feedbackState.reportEntity.length,
            itemBuilder: (context, int index) {
              return Card(
                  elevation: 8,
                  shadowColor: Colors.green,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                "Stars: ",
                              ),
                              Text(
                                feedbackState.reportEntity[index].star
                                    .toString(),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Message: ${feedbackState.reportEntity[index].message ?? "N/A"}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        feedbackState.reportEntity[index].appointment != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Appointment id: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    feedbackState.reportEntity[index]
                                                .appointment !=
                                            null
                                        ? feedbackState
                                            .reportEntity[index].appointment!.id
                                        : "N/A",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Feedback By: ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              feedbackState
                                      .reportEntity[index].feedback_by!.email ??
                                  "N/A",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Feedback Type: ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              feedbackState.reportEntity[index].feedback_for ??
                                  "N/A",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
            })
        : const Center(
            child: Text(
              "No Report",
            ),
          );
  }
}
