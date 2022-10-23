import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';

class ApplyCounsellorButtonScreen extends StatefulWidget {
  const ApplyCounsellorButtonScreen({Key? key}) : super(key: key);

  @override
  State<ApplyCounsellorButtonScreen> createState() =>
      _ApplyCounsellorButtonScreenState();
}

class _ApplyCounsellorButtonScreenState
    extends State<ApplyCounsellorButtonScreen> {
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Button
                const SizedBox(
                  height: 20,
                ),

                ActionButton(
                  background: CustomColors.primaryBlue,
                  width: size.width,
                  height: 50,
                  borderRadius: 10,
                  text: Text(
                    "Apply for Verification",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    UserModel? userInfo =
                        await signUpLocalDataSource.getUserDataFromLocal();
                    Navigator.pushNamed(
                      context,
                      Routes.APPLY_COUNSELLOR_SCREEN,
                      arguments: userInfo!.id,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ActionButton(
                  background: CustomColors.primaryBlue,
                  width: size.width,
                  height: 50,
                  borderRadius: 10,
                  text: Text(
                    "Appointment List",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.APPOINTMENTLIST);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ActionButton(
                  background: CustomColors.primaryBlue,
                  width: size.width,
                  height: 50,
                  borderRadius: 10,
                  text: Text(
                    "Add Time Table",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    UserModel? userInfo =
                        await signUpLocalDataSource.getUserDataFromLocal();
                    Navigator.pushNamed(
                      context,
                      Routes.ADD_MONTHLY_TIME_TABLE_SCREEN,
                      arguments: userInfo!.id,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
