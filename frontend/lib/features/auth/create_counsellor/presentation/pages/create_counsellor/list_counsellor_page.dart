import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/check_counsellor_status_bloc/check_counsellor_status_bloc.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/bloc/createcounsellor_bloc.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/pages/create_counsellor/view/create_counsellor_screen.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/presentation/check_user_status_bloc/check_user_status_bloc.dart';
import 'package:frontend/features/auth/user/presentation/get_user_details_list_bloc/get_user_details_list_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CounsellorList extends StatefulWidget {
  const CounsellorList({Key? key}) : super(key: key);

  @override
  State<CounsellorList> createState() => _CounsellorListState();
}

class _CounsellorListState extends State<CounsellorList> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CreatecounsellorBloc>(context)
        .add(GetCounsellorDetailsEvent());
    super.initState();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: "Counsellor List",
          backNavigate: () {}),
      // AppBar(
      //   title: Text("User List"),
      // ),
      body: BlocBuilder<CreatecounsellorBloc, CreatecounsellorState>(
        builder: (context, state) {
          if (state is GetCounsellorDetailsListLoadedState) {
            return BlocBuilder<CheckCounsellorStatusBloc,
                CheckCounsellorStatusState>(
              builder: (context, checkState) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ActionButton(
                          background: CustomColors.black,
                          width: size.width / 2,
                          height: 40,
                          borderRadius: 10,
                          text: Text(
                            "Add Counsellor",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          onPressed: () {
                            pushNewScreen(
                              context,
                              screen: CreateBussinessCounsellorScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.userData.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  height: 230,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: CustomColors.lightGrey,
                                            blurRadius: 12,
                                            offset: Offset(
                                              0,
                                              8,
                                            ))
                                      ]),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            state.userData[index]
                                                    .profile_image ??
                                                'assets/images/userlist.png',
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  state.userData[index].email ??
                                                      "example@example.com",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                // SizedBox(width: 2,),

                                                state.userData[index]
                                                            .is_active ==
                                                        true
                                                    ? Expanded(
                                                        child: OutlinedButton(
                                                            onPressed: () {},
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              side: const BorderSide(
                                                                  width: 2,
                                                                  color: CustomColors
                                                                      .primaryBlue),
                                                              shape:
                                                                  const CircleBorder(),
                                                            ),
                                                            child: const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.blue,
                                                              size: 20,
                                                            )),
                                                      )
                                                    :
                                                    //  SizedBox(width: 2,),

                                                    Expanded(
                                                        child: OutlinedButton(
                                                            onPressed: () {},
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              side: const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .red),
                                                              shape:
                                                                  CircleBorder(),
                                                            ),
                                                            child: const Icon(
                                                              Icons.clear,
                                                              color: Colors.red,
                                                              size: 20,
                                                            )),
                                                      )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  state.userData[index]
                                                          .user_role ??
                                                      "No Role",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 55.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'Delete User'),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Text(
                                                                            'Would you like to delete the user?'),
                                                                        Row(
                                                                          children: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                BlocProvider.of<CreatecounsellorBloc>(context).add(CounsellorStatusDeleteEvent(userdata: User(id: state.userData[index].id)));

                                                                                Navigator.pop(context, 'Ok');
                                                                              },
                                                                              child: const Text('OK'),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                        );
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  CustomColors
                                                                      .red,
                                                              shape:
                                                                  CircleBorder(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5)),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )),
                                                ),
                                                Column(
                                                  children: [
                                                    Text("Active"),
                                                    Center(
                                                      child: Switch(
                                                        value: state
                                                            .userData[index]
                                                            .is_active!,
                                                        onChanged: (value) {
                                                          // value != isSwitched;
                                                          setState(() {
                                                            state
                                                                .userData[index]
                                                                .is_active = value;
                                                          });

                                                          BlocProvider.of<
                                                                      CheckCounsellorStatusBloc>(
                                                                  context)
                                                              .add(
                                                            CounsellorStatusCheckEvent(
                                                              userdata: User(
                                                                is_active:
                                                                    value,
                                                                id: state
                                                                    .userData[
                                                                        index]
                                                                    .id,
                                                                is_suspended: state
                                                                    .userData[
                                                                        index]
                                                                    .is_suspended,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("Suspend"),
                                                    Center(
                                                      child: Switch(
                                                        value: state
                                                            .userData[index]
                                                            .is_suspended!,
                                                        onChanged: (value) {
                                                          // value != isSwitched;
                                                          setState(() {
                                                            state
                                                                .userData[index]
                                                                .is_suspended = value;
                                                          });

                                                          BlocProvider.of<
                                                                      CheckCounsellorStatusBloc>(
                                                                  context)
                                                              .add(
                                                            CounsellorStatusCheckEvent(
                                                              userdata: User(
                                                                  is_active:
                                                                      value,
                                                                  id: state
                                                                      .userData[
                                                                          index]
                                                                      .id,
                                                                  is_suspended:
                                                                      value),
                                                            ),
                                                          );
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return AppLoadingWidget();
          }
        },
      ),
    );
  }
}
