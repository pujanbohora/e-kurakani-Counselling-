// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/adminScreen.dart';
import 'package:frontend/businessScreen.dart';
import 'package:frontend/counsellorScreen.dart';
import 'package:frontend/customerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/core/utils/image_constants.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/sign_up_register_user.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';
import 'package:frontend/injectable.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var signUpRRepositorUser = getIt<SignUpRegisterUser>();
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  final prefs = getIt<SharedPreferences>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // _signinformKey = GlobalKey<FormState>();

  String? email;
  String? lastName;

  FocusNode emailFocusNode = FocusNode();

  bool canClearConfirmPasswordError = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String selectedValue = "Business";

  void selectValueRadioButton(String selectValue) {
    setState(() {
      selectedValue = selectValue;
    });
  }

  bool rememberMe = false;
  bool _isCheckedRememberMe = false;

  //handle remember me function
  void _handleRemeberme(bool value) {
    _isCheckedRememberMe = value;
    prefs.setBool("remember_me", value);
    setState(() {
      _isCheckedRememberMe = value;
    });

    // prefs.getKeys("remember_me");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) async {
          UserModel? userInfo =
              await signUpLocalDataSource.getUserDataFromLocal();
          if (state is LoginWithPasswordUserVerfiyedAdminState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScreen(
                  menuScreenContext: context,
                  userInfo: userInfo,
                ),
              ),
            );
            // Navigator.pushNamed(
            //     context, Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN);
          } else if (state is LoginWithPasswordUserVerfiyedCustomerState) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.BottNav_Customer, (route) => false);
            // Navigator.pushNamed(
            //     context, Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN);
            // Navigator.pushNamed(context, Routes.CUSTOMER_APPOINTMENT_LIST);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerScreen(
                  menuScreenContext: context,
                  userInfo: userInfo,
                ),
              ),
            );
          } else if (state is LoginWithPasswordUserVerfiyedBusinessState) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.BottNav_Business, (route) => false);
            // Navigator.pushNamed(
            //     context, Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessScreen(
                    menuScreenContext: context,
                    userInfo: userInfo,
                  ),
                ));
          } else if (state is LoginWithPasswordUserVerfiyedCounsellorState) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.BottNav_Counsellor, (route) => false);
            // Navigator.pushNamedAndRemoveUntil(context,
            //     Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN, (route) => false);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.APPLY_COUNSELLOR_BUTTON, (route) => false);
            // Navigator.pushNamed(
            //     context, Routes.CREATE_REQUEST_CATEGORY_VIEW_SCREEN);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CounsellorScreen(
                  menuScreenContext: context,
                  userInfo: userInfo,
                ),
              ),
            );
          } else if (state is LoginWithPasswordUserNotVerfiyedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: Duration(seconds: 1),
            ));
          } else if (state is LoginWithPasswordFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message ?? "Login Failed"),
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: size.width,
                    height: 85,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(ImageConst.LOGO))),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  'LOGIN',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.bold),
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
                          text: TextSpan(
                            text: 'Email',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: CustomColors.red,
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
                        hintText: 'Enter your email',
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
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
                        // validator: (value) =>
                        // Validators.validatePassword(value, false),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                                value: rememberMe,
                                activeColor: CustomColors.primaryBlue,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => CustomColors.primaryBlue),
                                checkColor: CustomColors.white,
                                onChanged: (newValue) {
                                  //todo write code for remember me
                                  setState(() {
                                    rememberMe = newValue!;
                                  });
                                  _handleRemeberme(newValue!);
                                }),
                            Text(
                              'Remember me',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: ActionButton(
                            background: CustomColors.primaryBlue,
                            isLoading: state is LoginWithPasswordLoadingState
                                ? true
                                : false,
                            width: size.width,
                            height: 55,
                            borderRadius: 10,
                            text: Text(
                              "LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    LoginiWithPasswordEvent(
                                        user: UserModel(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            user_role: 'Customer')));
                              }
                            }),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                Routes.GENERAL_USER_REGISTRATION_SCREEN);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      Routes.GENERAL_USER_REGISTRATION_SCREEN);
                                },
                                child: Text(
                                  "SIGNUP",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: CustomColors.primaryBlue,
                                          fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.FORGOT_PASSWORD);
                            },
                            child: Text(
                              'Forget Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      color: CustomColors.primaryBlue,
                                      fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
