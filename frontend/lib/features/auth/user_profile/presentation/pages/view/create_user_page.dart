// Flutter imports:
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/Sign_in_response.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';
import 'package:frontend/features/auth/user/presentation/get_user_details_list_bloc/get_user_details_list_bloc.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  // var signUpRRepositorUser = getIt<SignUpRegisterUser>();

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? lastName;

  FocusNode emailFocusNode = FocusNode();

  bool canClearConfirmPasswordError = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Dio dio = Dio();

  bool isLoading = false;

  var selectedValue = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: 'Create User',
          appBarBackgroupColor: CustomColors.white,
          textColor: CustomColors.black,
          iconColor: CustomColors.primaryBlue,
          // settingIcon: Icon(Icons.abc_rounded),
          backNavigate: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child:
            //  BlocProvider<CreatecounsellorBloc>(
            //   create: (context) => CreatecounsellorBloc(),
            //   child:
            // BlocConsumer<CreatecounsellorBloc, CreatecounsellorState>(
            // listener: (context, state) {
            //   if (state is CreateCounsellorLoadedState) {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //       content: Text('Registration sucess!'),
            //       duration: Duration(seconds: 1),
            //     ));
            //   } else if (state is CreateCounsellorFailedState) {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Text('Error while submitting data!')));
            //   }
            // },
            // builder: (context, state) {
            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Add Counsellor',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Email',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InputField(
                      textEditingController: emailController,
                      focusNode: emailFocusNode,
                      validator: Validators.validateEmail,
                      textInputAction: TextInputAction.next,
                      getInputFieldValue: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                      hintText: 'Emter email of counsellor',
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Password',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomFormField(
                      fieldName: '',
                      textEditingController: passwordController,
                      isObscure: true,
                      hint: 'Password',
                      validator: (value) =>
                          Validators.validatePassword(value, false),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Confirm Password',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomFormField(
                      fieldName: '',
                      textEditingController: confirmPasswordController,
                      isObscure: true,
                      hint: 'Confirm Password',
                      validator: (value) => Validators.validateConfirmPassword(
                          passwordController.text,
                          value,
                          canClearConfirmPasswordError),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'User Role',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: DropdownButton<String>(
                        // value: , //selected
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          selectedValue = newValue!;
                        },
                        items: <String>[
                          'Admin',
                          'Counsellor',
                          'Bussiness',
                          'Customer'
                        ].map<DropdownMenuItem<String>>((String selectedValue) {
                          return DropdownMenuItem<String>(
                            value: selectedValue,
                            child: Text(selectedValue.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ActionButton(
                          background: CustomColors.primaryBlue,
                          width: size.width,
                          height: 55,
                          isLoading: isLoading,
                          // state is SignupLoadingState ? true : false,
                          borderRadius: 10,
                          text: Text(
                            "Create User",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              var userInfo = User(
                                  email: emailController.text,
                                  user_role: selectedValue,
                                  password: passwordController.text);
                              createUserApi(userInfo);
                            }
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );

    // ),
  }

  void createUserApi(User userInfo) async {
    setState(() {
      isLoading = true;
    });

    UserModel userModel = UserModel(
        email: userInfo.email,
        user_role: userInfo.user_role,
        password: userInfo.password);

    var userToJson = userModel.toJson();

    userToJson.removeWhere((key, value) => value == null);

    var data = jsonEncode(userToJson);

    print("below is user create data");

    print(data);

    final response = await dioClient.post(
      Urls.USER_LIST,
      data: data,
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Updated!'),
        duration: Duration(seconds: 1),
      ));
      BlocProvider.of<GetUserDetailsListBloc>(context)
          .add(GetUserDetailsEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error!'),
        duration: Duration(seconds: 1),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }
}
