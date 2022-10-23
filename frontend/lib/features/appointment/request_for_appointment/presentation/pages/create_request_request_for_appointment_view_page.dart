// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/create_request_entity.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/usecasess/save_request_appointment_usecase.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/bloc/create_request_bloc/create_request_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';

class CreateRequestRequestForAppointmentViewScreen extends StatefulWidget {
  const CreateRequestRequestForAppointmentViewScreen({Key? key})
      : super(key: key);

  @override
  State<CreateRequestRequestForAppointmentViewScreen> createState() =>
      _CreateRequestRequestForAppointmentViewScreenState();
}

class _CreateRequestRequestForAppointmentViewScreenState
    extends State<CreateRequestRequestForAppointmentViewScreen> {
  var saveRequestForAppointment = getIt<SaveRequestForAppointment>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  final TextEditingController _reasonForRequestController =
      TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String dobOnChangeValue = "";

  final _formKey = GlobalKey<FormBuilderState>();

  bool? _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;

    super.initState();
  }

  void _buttonDisable() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final args = ModalRoute.of(context)!.settings.arguments as String;

    return BlocConsumer<CreateRequestBloc, CreateRequestState>(
      listener: (context, state) {
        if (state is SaveCreateRequestAppointmentLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Request sucess!'),
            duration: Duration(seconds: 1),
          ));
        } else if (state is SaveCreateRequestAppointmentFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Request Failed!'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffE4F2F7),
          appBar: appBar(
              noBackButton: false,
              navTitle: 'Request For Appointment',
              appBarBackgroupColor: CustomColors.white,
              textColor: CustomColors.black,
              iconColor: CustomColors.primaryBlue,
              backNavigate: () {
                Navigator.pop(context);
              }),
          body: SingleChildScrollView(
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
                        Text("Choose Your Prefered Date",
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',
                          controller: _dateController,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              EvaIcons.calendarOutline,
                            ),
                            prefixIconColor: Colors.black,
                            fillColor: Colors.white,
                            errorStyle:
                                TextStyle(color: Color.fromRGBO(2, 40, 89, 1)),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 15,
                            ),
                            hintText: "DD/MM/YYYY",
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
                              dobOnChangeValue = val;
                            });
                          },
                          validator: (val) {
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        Text("Choose Your Prefered Time",
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        CustomTextField(
                          textController: _timeController,
                          validator: FormBuilderValidators.required(
                              errorText: 'Prefered Time is required'),
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
                            labelText: 'Before 12 am',
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                          ),
                          attribute: 'name',
                        ),

                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        Text('Message',
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          textController: _reasonForRequestController,
                          maxLines: 7,
                          borderColor: CustomColors.black,
                          validator: FormBuilderValidators.required(
                            errorText: 'Reason for request is required',
                          ),
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
                            hintText: 'Request for request',
                            contentPadding: const EdgeInsets.only(
                              bottom: 10,
                              left: 12,
                              right: 12,
                            ),
                          ),
                          attribute: 'text',
                        ),

                        //Button
                        const SizedBox(
                          height: 20,
                        ),

                        ActionButton(
                            background: _isButtonDisabled!
                                ? CustomColors.lightGrey
                                : CustomColors.primaryBlue,
                            width: size.width,
                            height: 50,
                            borderRadius: 10,
                            isLoading: state
                                    is SaveCreateRequestAppointmentLoadingState
                                ? true
                                : false,
                            text: Text(
                              "SUBMIT",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            onPressed: _isButtonDisabled!
                                ? () {
                                    null;
                                  }
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      UserModel? userInfo =
                                          await signUpLocalDataSource
                                              .getUserDataFromLocal();
                                      // print(userInfo!.id);

                                      // print( keys!["id"]);

                                      BlocProvider.of<CreateRequestBloc>(
                                              context)
                                          .add(SaveRequestForAppointmentEvent(
                                              createRequestEntity:
                                                  CreateRequestEntiry(
                                                      user: userInfo!.id,
                                                      counsellor: args,
                                                      date:
                                                          _dateController.text,
                                                      time:
                                                          _timeController.text,
                                                      remarks:
                                                          _reasonForRequestController
                                                              .text)));
                                      _buttonDisable();
                                      // Navigator.pushNamed(
                                      //     context,
                                      //     Routes
                                      //         .CREATE_REQUEST_REQUEST_FOR_APPOINTMENT_VIEW_SCREEN);
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
    );
  }
}
