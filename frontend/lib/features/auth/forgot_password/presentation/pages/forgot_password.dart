import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/features/auth/forgot_password/presentation/bloc/forget_password_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/image_constants.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../../sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  FocusNode emailFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordEmailVerifyLoadedState) {
              Navigator.pushNamed(context, Routes.FORGET_PASSWORD_OTP_SCREEN);
            }
            if (state is ForgetPasswordEmailVerifyFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('Please enter correct email!'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(ImageConst.LOGO),
                        ),
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 214, 240, 249),
                            Color.fromARGB(255, 243, 243, 243),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Please Enter Your Email Address To Receive a Verification Code",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: CustomColors.black,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Email Address',
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
                        getInputFieldValue: (String value) {},
                        hintText: 'Enter your email',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: ActionButton(
                        background: CustomColors.primaryBlue,
                        isLoading:
                            state is ForgetPasswordEmailVerifyLoadingState
                                ? true
                                : false,
                        width: size.width,
                        height: 55,
                        borderRadius: 10,
                        text: Text(
                          "Send",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, Routes.FORGET_PASSWORD_OTP_SCREEN);

                          BlocProvider.of<ForgetPasswordBloc>(context).add(
                            ForgetPasswordEmailVerifyEvent(
                              userModel: UserModel(
                                email: emailController.text,
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
