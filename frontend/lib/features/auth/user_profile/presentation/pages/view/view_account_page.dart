import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_in/view/sign_in_view.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/change_password_page.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/userprofile.dart';
import 'package:frontend/features/auth/user_profile/presentation/user_profile_bloc/user_profile_bloc.dart';
import 'package:frontend/features/profiles/presentation/pages/business_profile/view/apply_business_profile_page.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/apply_counsellor_profile_page.dart';
import 'package:frontend/get_current_user.dart';
import 'package:frontend/injectable.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ViewAccountScreen extends StatefulWidget {
  const ViewAccountScreen({Key? key}) : super(key: key);

  @override
  State<ViewAccountScreen> createState() => _ViewAccountScreenState();
}

class _ViewAccountScreenState extends State<ViewAccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("your are in profile page");
    BlocProvider.of<UserProfileBloc>(context)..add(GetUserProfileEvent());

    super.initState();
  }

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    double heightBetweenTextField = mediaQueryHeight * 0.04;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar:
          appBar(noBackButton: true, navTitle: "Profile ", backNavigate: () {}),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is GetUserProfileLoadedState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 40,
                                      backgroundImage: state.getUserData
                                                  .details!.profile_image !=
                                              null
                                          ? NetworkImage(state.getUserData
                                              .details!.profile_image!)
                                          : const AssetImage(
                                                  "assets/images/counsellor_profile_image.jpeg")
                                              as ImageProvider),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.getUserData.details!
                                                      .full_name !=
                                                  null
                                              ? state.getUserData.details!
                                                  .full_name!
                                              : "N/A",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                        ),
                                        Text(
                                          state.getUserData.email!,
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyText2!
                                          //     .copyWith(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 16,
                                          //     ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mediaQueryHeight * 0.03,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Contact Number",
                                    ),
                                    SizedBox(
                                      height: mediaQueryHeight * 0.01,
                                    ),
                                    Text(
                                      state.getUserData.details!
                                                  .contact_number !=
                                              null
                                          ? state.getUserData.details!
                                              .contact_number!
                                          : "N/A",
                                    ),
                                    SizedBox(
                                      height: heightBetweenTextField,
                                    ),
                                    const Text(
                                      'Bio',
                                    ),
                                    SizedBox(
                                      height: mediaQueryHeight * 0.01,
                                    ),
                                    Text(
                                      state.getUserData.details!.bio != null
                                          ? state.getUserData.details!.bio!
                                          : "N/A",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mediaQueryHeight * 0.04,
                        ),
                        InkWell(
                          onTap: () {
                            pushNewScreenWithRouteSettings(context,
                                screen: EditProfilePage(
                                  userDetails: state.getUserData.details,
                                ),
                                settings: const RouteSettings(
                                    name: Routes.EditProfilePage));
                          },
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Icon(Icons.edit),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edit Profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: CustomColors.black,
                                          fontSize: 16,
                                          fontFamily: "blackTextSemiBold"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () {
                            pushNewScreenWithRouteSettings(context,
                                screen: const ChangePasswordScreen(),
                                settings: const RouteSettings(
                                    name: Routes.CHANGE_PASSWORD_SCREEN));
                          },
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Icon(Icons.password),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Change Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: CustomColors.black,
                                          fontSize: 16,
                                          fontFamily: "blackTextSemiBold"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        state.getUserData.user_role == "Counsellor" ||
                                state.getUserData.user_role == "Business"
                            ? (Column(
                                children: [
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // await logOutCurrentUser;
                                      UserModel? userInfo =
                                          await signUpLocalDataSource
                                              .getUserDataFromLocal();
                                      pushNewScreen(
                                        context,
                                        screen: state.getUserData.user_role ==
                                                "Counsellor"
                                            ? ApplyCounsellorProfileScreen(
                                                userId: userInfo!.id)
                                            : ApplyBusinessProfileScreen(
                                                userId: userInfo!.id,
                                              ),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.verified_outlined),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Apply For Verification',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: CustomColors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        "blackTextSemiBold"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))
                            : Container(),
                        const Divider(
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () async {
                            await logOutCurrentUser;
                            pushNewScreen(
                              context,
                              screen: SigninPage(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Icon(Icons.logout),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Log Out',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: CustomColors.black,
                                          fontSize: 16,
                                          fontFamily: "blackTextSemiBold"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                );
              } else if (state is GetUserProfileLoadingState) {
                return const AppLoadingWidget();
              } else {
                return const Text("Unable to Fetch Data");
              }
            },
          ),
        ),
      ),
    );
  }
}
