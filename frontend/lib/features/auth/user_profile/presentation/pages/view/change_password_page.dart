import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
import 'package:frontend/features/auth/user_profile/presentation/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:frontend/injectable.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldpasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("thisis the otp of the otp screen");
    // TODO: implement initState

    super.initState();
  }

  var isLoading = false;

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: "Change Password",
          backNavigate: () {}),
      body: BlocListener<EditUserProfileBloc, EditUserProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ChangePasswordLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password has been updated'),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is ChangePasswordFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error! Password has not been updated'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RichText(
                              text: TextSpan(
                                text: 'Old Password',
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
                                oldpasswordController.text, false),
                            fieldName: '',
                            textEditingController: oldpasswordController,
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
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                    newPasswordController.text, value, false),
                            fieldName: '',
                            textEditingController: newPasswordController,
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
                                state is ChangePasswordLoading ? true : false,
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
                                // BlocProvider.of<EditUserProfileBloc>(context)
                                //     .add(ChangePasswordEvent(
                                //         new_password:
                                //             newPasswordController.text,
                                //         old_password:
                                //             oldpasswordController.text));

                                var statusCode = changePassword(
                                    newPasswordController.text,
                                    oldpasswordController.text);
                                newPasswordController.clear();
                                oldpasswordController.clear();
                              }
                            }),
                      )
                    ],
                  ),
                ),
              )),
            );
          },
        ),
      ),
    );
  }

  changePassword(String new_password, String old_password) async {
    UserModel? userInfo = await signUpLocalDataSource.getUserDataFromLocal();

    String? id = userInfo!.id;

    final response = await dioClient.patch(Urls.CHAGNE_PASSWORD,
        data: {"old_password": old_password, "new_password": new_password});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password has been updated!'),
        // duration: Duration(seconds: 1),
      ));

      // UserDetailsModel userData = UserDetailsModel.fromJson(response.data);

      return response.statusCode;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Errord!'),
        // duration: Duration(seconds: 1),
      ));
      return Future.error("User Get Failed");
    }
  }
}
