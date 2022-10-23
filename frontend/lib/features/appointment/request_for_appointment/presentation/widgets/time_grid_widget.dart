import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/timetable_model.dart';
import 'package:frontend/injectable.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../bloc/create_request_bloc/create_request_bloc.dart';

class TimeGrid extends StatefulWidget {
  TimeGrid(
      {Key? key,
      required this.price,
      required this.timeTableModel,
      required this.counsellorId,
      required this.requested_by})
      : super(key: key);
  List<TimeTableModel>? timeTableModel;
  final String requested_by;
  final String counsellorId;
  final double price;
  //  availableTime;

  @override
  State<TimeGrid> createState() => _TimeGridState();
}

class _TimeGridState extends State<TimeGrid> {
  bool hasBeenClicked = false;
  int clickedIndex = 0;
  String dateChange = "";

  String? requestedTime;
  String? requestedDate;
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  Widget build(BuildContext context) {
    print(widget.timeTableModel);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CreateRequestBloc, CreateRequestState>(
      listener: (context, state) {
        if (state is SaveCreateRequestAppointmentFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Appointment Failed!'),
            // duration: Duration(seconds: 1),
          ));
        } else if (state is SaveCreateRequestAppointmentLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Appointment Success!'),
            // duration: Duration(seconds: 1),
          ));
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
            child: widget.timeTableModel!.length > 0
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: size.height * 0.43,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 80,
                                    crossAxisCount: 1,
                                    childAspectRatio: 6 / 2),
                            itemCount: widget.timeTableModel!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffE4F2F7),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget.timeTableModel![index]
                                                          .date !=
                                                      null
                                                  ? widget
                                                      .timeTableModel![index]
                                                      .date!
                                                  : "N/A",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color:
                                                          CustomColors.black),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  widget.timeTableModel![index]
                                                              .start_time !=
                                                          null
                                                      ? widget
                                                          .timeTableModel![
                                                              index]
                                                          .start_time!
                                                      : "N/A",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: CustomColors
                                                              .black),
                                                ),
                                                const Text(" - "),
                                                Text(
                                                  widget.timeTableModel![index]
                                                              .end_time !=
                                                          null
                                                      ? widget
                                                          .timeTableModel![
                                                              index]
                                                          .end_time!
                                                      : "N/A",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: CustomColors
                                                              .black),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        SizedBox(
                                          // width:  50,
                                          height: 40,
                                          child: GridView.builder(
                                              physics: const ScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: widget
                                                  .timeTableModel![index]
                                                  .intervals!
                                                  .length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                crossAxisSpacing: 15.0,
                                                mainAxisSpacing: 15.0,
                                                childAspectRatio: 0.5,
                                              ),
                                              itemBuilder:
                                                  (context, intevalIndex) {
                                                bool hasBeenClicked =
                                                    intevalIndex ==
                                                            clickedIndex &&
                                                        dateChange ==
                                                            widget
                                                                .timeTableModel![
                                                                    index]
                                                                .date!;
                                                return Material(
                                                    elevation: 2.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: hasBeenClicked
                                                        ? CustomColors
                                                            .primaryBlue
                                                        : Colors.white,
                                                    child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        child: SizedBox(
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                widget.timeTableModel![index].intervals![intevalIndex] !=
                                                                        null
                                                                    ? widget
                                                                        .timeTableModel![
                                                                            index]
                                                                        .intervals![intevalIndex]!
                                                                    : "N/A",
                                                                style: hasBeenClicked
                                                                    ? Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                            color: Colors
                                                                                .white)
                                                                    : Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.black87),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          requestedTime = widget
                                                                  .timeTableModel![
                                                                      index]
                                                                  .intervals![
                                                              intevalIndex]!;
                                                          requestedDate = widget
                                                              .timeTableModel![
                                                                  index]
                                                              .date;
                                                          setState(() {
                                                            clickedIndex =
                                                                intevalIndex;
                                                            dateChange = widget
                                                                .timeTableModel![
                                                                    index]
                                                                .date!;
                                                          });
                                                        }));
                                              }),
                                        ),
                                      ]),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      ActionButton(
                          background: CustomColors.primaryBlue,
                          width: size.width,
                          height: 50,
                          borderRadius: 10,
                          isLoading:
                              state is SaveCreateRequestAppointmentLoadingState
                                  ? true
                                  : false,
                          text: Text(
                            "BOOK APPOINTMENT",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          onPressed: () {
                            if (requestedTime != null) {
                              KhaltiScope.of(context).pay(
                                config: PaymentConfig(
                                  amount: widget.price.toInt() * 10,
                                  productIdentity: 'Counsellor fee',
                                  productName: widget.counsellorId,
                                ),
                                preferences: [
                                  PaymentPreference.khalti,
                                ],
                                onSuccess: (su) async {
                                  print(requestedDate);
                                  print(requestedTime);
                                  UserModel? userInfo =
                                      await signUpLocalDataSource
                                          .getUserDataFromLocal();
                                  BlocProvider.of<CreateRequestBloc>(context)
                                      .add(SaveRequestForAppointmentEvent(
                                          createRequestEntity:
                                              CreateRequestEntiry(
                                                  user: userInfo!.id!,
                                                  counsellor:
                                                      widget.counsellorId,
                                                  date: requestedDate,
                                                  time: requestedTime,
                                                  amount: su.amount.toDouble(),
                                                  token: su.token)));

                                  // const successsnackBar = SnackBar(
                                  //   content: Text('Payment Successful'),
                                  // );
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(successsnackBar);
                                },
                                onFailure: (fa) {
                                  const failedsnackBar = SnackBar(
                                    content: Text('Payment Failed'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(failedsnackBar);
                                },
                                onCancel: () {
                                  const cancelsnackBar = SnackBar(
                                    content: Text('Payment Cancelled'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(cancelsnackBar);
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Please select Time!'),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          })
                    ],
                  )
                : Text(
                    "Counsellor has not added their schedule",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black, fontSize: 16),
                  ));
      },
    );
  }
}
