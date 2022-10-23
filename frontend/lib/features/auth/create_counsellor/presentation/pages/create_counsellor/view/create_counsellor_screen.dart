// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/image_constants.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/createcounsellor_bloc.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/pages/create_counsellor/list_counsellor_page.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CreateBussinessCounsellorScreen extends StatefulWidget {
  const CreateBussinessCounsellorScreen({Key? key}) : super(key: key);

  @override
  State<CreateBussinessCounsellorScreen> createState() =>
      _CreateBussinessCounsellorScreenState();
}

class _CreateBussinessCounsellorScreenState
    extends State<CreateBussinessCounsellorScreen> {
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

  clearTextField() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      body: SafeArea(
        child: BlocProvider<CreatecounsellorBloc>(
          create: (context) => CreatecounsellorBloc(),
          child: BlocConsumer<CreatecounsellorBloc, CreatecounsellorState>(
            listener: (context, state) {
              if (state is CreateCounsellorLoadedState) {
                clearTextField();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Registration sucess!'),
                  duration: Duration(seconds: 1),
                ));
              } else if (state is CreateCounsellorFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error while submitting data!')));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ActionButton(
                      background: CustomColors.black,
                      width: size.width / 2,
                      height: 40,
                      borderRadius: 10,
                      text: Text(
                        "View Counsellor",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () {
                        BlocProvider.of<CreatecounsellorBloc>(context)
                            .add(GetCounsellorDetailsEvent());
                        pushNewScreen(
                          context,
                          screen: CounsellorList(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
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
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                    passwordController.text,
                                    value,
                                    canClearConfirmPasswordError),
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
                                isLoading:
                                    state is SignupLoadingState ? true : false,
                                borderRadius: 10,
                                text: Text(
                                  "Register",
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
                                    var selectedValue = "Counsellor";
                                    BlocProvider.of<CreatecounsellorBloc>(
                                            context)
                                        .add(RegisterCounsellorEvent(
                                            user: User(
                                                email: emailController.text,
                                                user_role: selectedValue,
                                                associated_business:
                                                    "business@gmail.com",
                                                password:
                                                    passwordController.text)));
                                    // Future.delayed(const Duration(seconds: 3),
                                    //     () {
                                    //   Navigator.pushNamed(
                                    //       context, Routes.SIGN_IN);
                                    // });
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
              );
            },
          ),
        ),
      ),
    );
  }
}
