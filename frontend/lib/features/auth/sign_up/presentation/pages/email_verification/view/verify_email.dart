import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/image_constants.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/email_verify.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/email_verify_bloc/email_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<EmailBloc, EmailState>(
      listener: (context, state) {
        if (state is EmailVerifyLoadedState) {
          Navigator.pushNamed(context, Routes.SIGN_IN);
        } else if (state is EmailVerifyFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error!! while verifying code'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                          "Enter the 6 digit code we sent you via email to continue",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                  ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        PinCodeTextField(
                          appContext: context,
                          // pastedTextStyle: const TextStyle(
                          //   color: Colors.white,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          showCursor: true,

                          length: 6,
                          animationType: AnimationType.fade,
                          blinkWhenObscuring: true,
                          textStyle: const TextStyle(color: CustomColors.black),
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 47,
                              activeColor: Colors.black,
                              selectedColor: Colors.black,
                              inactiveColor: Colors.black),
                          cursorColor: CustomColors.black,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ActionButton(
                            background: CustomColors.primaryBlue,
                            width: size.width,
                            height: 55,
                            isLoading:
                                state is EmailVerifyLoadingState ? true : false,
                            borderRadius: 5,
                            text: Text(
                              "Verify",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              // formKey.currentState!.validate();
                              // conditions for validating
                              if (currentText.length != 6) {
                                snackBar("Incorrect OTP");
                              } else {
                                BlocProvider.of<EmailBloc>(context).add(
                                    EmailVerificationEvent(
                                        emailVerifyCode:
                                            EmailVerifyCode(otp: currentText)));
                              }
                              print("the below is otp code");
                              // print(otpController.text);
                            }),
                        const SizedBox(
                          height: 14,
                        ),
                        InkWell(
                          onTap: () {},
                          child: RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  children: [
                                TextSpan(
                                    text: "Didn't get OTP code ? ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Colors.black,
                                        )),
                                const TextSpan(
                                    text: "Resend OTP Code",
                                    style: TextStyle(color: CustomColors.red))
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ), //
            ),
          ),
        );
      },
    );
  }
}
