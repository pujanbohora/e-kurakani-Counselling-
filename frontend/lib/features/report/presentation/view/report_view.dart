import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/report/presentation/bloc/report_bloc/report_bloc.dart';

import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/profiles/presentation/bloc/profile_request/profile_request_bloc.dart';

class ReportViewScreen extends StatefulWidget {
  const ReportViewScreen({Key? key}) : super(key: key);

  @override
  State<ReportViewScreen> createState() => _ReportViewScreenState();
}

class _ReportViewScreenState extends State<ReportViewScreen> {
  @override
  void initState() {
    BlocProvider.of<ReportBloc>(context)
        .add(GetAppointmentReportEvent(type: "counsellor"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar:
          appBar(noBackButton: true, navTitle: "Reports", backNavigate: () {}),
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
                          "Counsellor Reports",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ReportBloc>(context).add(
                              GetAppointmentReportEvent(type: "counsellor"));
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
                          "Appointments Reports",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ReportBloc>(context).add(
                              GetAppointmentReportEvent(type: "appointment"));
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: double.infinity,
                child: BlocBuilder<ReportBloc, ReportState>(
                  builder: (context, state) {
                    if (state is GetAppointmentReportLoadedState) {
                      return _buildAppointmentbody(context, state);
                    } else if (state is GetAppointmentReportFailedState) {
                      return const Center(
                        child: Text("Couldn't fetch counsellor profiles"),
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

  Widget _buildAppointmentbody(context, state) {
    return state.reportEntity.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: state.reportEntity.length,
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
                          title: Text(
                            state.reportEntity[index].title ?? "N/A",
                          ),
                          subtitle: Text(
                            state.reportEntity[index].description ?? "N/A",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        state.reportEntity[index].appointment != null
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
                                    state.reportEntity[index].appointment !=
                                            null
                                        ? state
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
                              "Reported By: ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              state.reportEntity[index].reported_by!.email ??
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
                              "Report Type: ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              state.reportEntity[index].report_for ?? "N/A",
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
