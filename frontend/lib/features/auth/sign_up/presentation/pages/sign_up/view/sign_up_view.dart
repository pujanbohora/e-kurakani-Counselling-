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
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // var signUpRRepositorUser = getIt<SignUpRegisterUser>();

  // final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;
  String? lastName;

  FocusNode emailFocusNode = FocusNode();

  bool canClearConfirmPasswordError = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignupLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Registration sucess!'),
                duration: Duration(seconds: 1),
              ));
              Navigator.pushNamed(context, Routes.VERIFY_EMAIL);
            } else if (state is SignupFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error while submitting data!')));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      width: size.width,
                      height: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(ImageConst.LOGO)
                              )
                              ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'SIGNUP',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: ActionButton(
                        background: CustomColors.primaryBlue,
                        width: size.width,
                        height: 55,
                        borderRadius: 10,
                        text: Text(
                          "Create A Business Account",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,
                              Routes.BUSSINESS_USER_REGISTRATION_SCREEN);
                        }),
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
                          hintText: 'Emter your email',
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
                                "SIGN UP",
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
                                  var selectedValue = "Customer";
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      RegisterUserEvent(
                                          user: User(
                                              email: emailController.text,
                                              user_role: selectedValue,
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
                                  "Already have an account?",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.SIGN_IN);
                                  },
                                  child: Text(
                                    "LOGIN",
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
