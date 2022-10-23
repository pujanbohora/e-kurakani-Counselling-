import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/features/auth/forgot_password/presentation/bloc/forget_password_bloc.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/image_constants.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../../sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';

class CreateNewPassword extends StatefulWidget {
  CreateNewPassword({Key? key, required this.otp}) : super(key: key);

  final String otp;

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.FORGET_PASSWORD_OTP_SCREEN);
            // Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Create New Password',
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
            if (state is ForgetPasswordResetPasswordLoadedState) {
              Navigator.pushNamed(context, Routes.SIGN_IN);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Password changed successfully'),
                duration: Duration(seconds: 1),
              ));
            } else if (state is ForgetPasswordResetPasswordFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Error. please try again!'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            return Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: SizedBox(
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
                        "Your New Password Must Be Different from Previously Used Password",
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
                              text: 'New Password',
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
                          validator: (value) => Validators.validatePassword(
                              passwordController.text, false),
                          fieldName: '',
                          textEditingController: passwordController,
                          isObscure: true,
                          hint: 'Enter New Password',
                          // validator: (value) =>
                          // Validators.validatePassword(value, false),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Confirm Password',
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
                          validator: (value) =>
                              Validators.validateConfirmPassword(
                                  passwordController.text, value, false),
                          fieldName: '',
                          textEditingController: confirmPasswordController,
                          isObscure: true,
                          hint: 'Retype your Password',
                          // validator: (value) =>
                          // Validators.validatePassword(value, false),
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
                              state is ForgetPasswordResetPasswordLoadingState
                                  ? true
                                  : false,
                          width: size.width,
                          height: 55,
                          borderRadius: 10,
                          text: Text(
                            "Save",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<ForgetPasswordBloc>(context).add(
                                  ForgetPasswordResetPasswordEvent(
                                      user: User(
                                          password: passwordController.text,
                                          otp: widget.otp)));
                            }
                          }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
