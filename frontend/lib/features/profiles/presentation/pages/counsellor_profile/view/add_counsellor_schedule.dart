import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/Schedule/presentaion/bloc/schedule_list_bloc.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_timetable.dart';
import 'package:frontend/features/profiles/domain/usecases/counsellor_profile_usecase.dart';
import 'package:frontend/features/profiles/presentation/bloc/counsellor_bloc/counsellor_bloc.dart';
import 'package:frontend/injectable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AddCounsellorScheduleScreen extends StatefulWidget {
  final String? userId;
  const AddCounsellorScheduleScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AddCounsellorScheduleScreen> createState() =>
      _AddCounsellorScheduleScreenState();
}

class _AddCounsellorScheduleScreenState
    extends State<AddCounsellorScheduleScreen> {
  CounsellorProfile? profileData;

  List itemsValue = ["Error loading"];

  String date = "";
  String startTime = "";
  String endTime = "";

  String? dropDownValue;
  final _formKey = GlobalKey<FormBuilderState>();

  clearTextFiled() {
    date = "";
    startTime = "";
    endTime = "";
    dropDownValue = "";
  }

  @override
  void initState() {
    BlocProvider.of<CounsellorBloc>(context)
        .add(GetCounsellorEvent(userId: widget.userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      body: BlocConsumer<CounsellorBloc, CounsellorState>(
        listener: (context, state) {
          // print(state);
          if (state is CounsellorScheduleLoadedState) {
            // print(state);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Schedule Added!'),
              duration: Duration(seconds: 1),
            ));
            ScheduleListBloc().add(GetScheduleListEvent());
          }
          if (state is CounsellorScheduleFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Error!'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          (state is GetCounsellorLoadedState)
              ? profileData = state.counsellorProfileData
              : '';
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // dropdown for months
                          // start time
                          // end time
                          Text("Select Date",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          DateTimePicker(
                            firstDate: DateTime(2022, 7, 1),
                            lastDate: DateTime(2023, 7, 1),
                            type: DateTimePickerType.date,
                            use24HourFormat: true,
                            timeLabelText: 'Date',
                            initialValue: date,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                EvaIcons.clock,
                              ),
                              prefixIconColor: Colors.black,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(
                                  color: Color.fromRGBO(2, 40, 89, 1)),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 15,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                            ),
                            onChanged: (val) {
                              setState(() {
                                date = val;
                              });
                            },
                            onSaved: (val) => print(val),
                          ),

                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text("Start Time",
                              style: Theme.of(context).textTheme.bodyText1),
                          DateTimePicker(
                            type: DateTimePickerType.time,
                            use24HourFormat: true,
                            timeLabelText: 'Start Time',
                            initialValue: startTime,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                EvaIcons.clock,
                              ),
                              prefixIconColor: Colors.black,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(
                                  color: Color.fromRGBO(2, 40, 89, 1)),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 15,
                              ),
                              hintText: "11:00",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                            ),
                            onChanged: (val) {
                              print("Changed $val");
                              setState(() {
                                startTime = val;
                              });
                            },
                            // validator: (val) {
                            //   print(val);
                            //   return null;
                            // },
                            onSaved: (val) => print(val),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text("End Time",
                              style: Theme.of(context).textTheme.bodyText1),
                          DateTimePicker(
                            type: DateTimePickerType.time,
                            use24HourFormat: true,
                            timeLabelText: 'End Time',
                            initialValue: endTime,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                EvaIcons.clock,
                              ),
                              prefixIconColor: Colors.black,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(
                                  color: Color.fromRGBO(2, 40, 89, 1)),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 15,
                              ),
                              hintText: "17:00",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                            ),
                            onChanged: (val) {
                              setState(() {
                                print("Inside set state $val");
                                endTime = val;
                              });
                            },
                            // validator: (val) {
                            //   print(val);
                            //   return null;
                            // },
                            onSaved: (val) => print(val),
                          ),

                          //Button
                          const SizedBox(
                            height: 20,
                          ),

                          ActionButton(
                              background: CustomColors.primaryBlue,
                              width: size.width,
                              height: 50,
                              borderRadius: 10,
                              isLoading:
                                  state is CounsellorLoadedState ? true : false,
                              text: Text(
                                "Add Schedule",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<CounsellorBloc>(context).add(
                                    AddCounsellorScheduleEvent(
                                      timeTableEntity: CounsellorTimeTable(
                                        date: date,
                                        start_time: startTime,
                                        end_time: endTime,
                                        counsellor: CounsellorProfileModel(
                                            id: profileData!.id),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
