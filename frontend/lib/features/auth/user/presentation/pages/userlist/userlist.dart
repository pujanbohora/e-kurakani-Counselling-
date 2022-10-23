import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user.dart';
import 'package:frontend/features/auth/user/presentation/check_user_status_bloc/check_user_status_bloc.dart';
import 'package:frontend/features/auth/user/presentation/get_user_details_list_bloc/get_user_details_list_bloc.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/create_user_page.dart';
import 'package:frontend/features/category/presentation/pages/add_category/view/add_category_page.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetUserDetailsListBloc>(context)
      ..add(GetUserDetailsEvent());
    super.initState();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: AppBar(
        title: const Text(
          "User List",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color(0xffE4F2F7),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCategoryScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateUserScreen()),
                                );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: const Text('Create User',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                )),
          )
        ],
      ),
      // appBar(
      //     noBackButton: false, navTitle: "User Lists", backNavigate: () {}),
      // AppBar(
      //   title: Text("User List"),
      // ),
      body: BlocBuilder<GetUserDetailsListBloc, GetUserDetailsListState>(
        builder: (context, state) {
          if (state is GetUserDetailsListLoadedState) {
            return BlocBuilder<CheckUserStatusBloc, CheckUserStatusState>(
                builder: (context, checkState) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.userData.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                      state.userData[index].profile_image ??
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

                                          state.userData[index].is_active ==
                                                  true
                                              ? Expanded(
                                                  child: OutlinedButton(
                                                      onPressed: () {},
                                                      style: OutlinedButton
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
                                                        color: Colors.blue,
                                                        size: 20,
                                                      )),
                                                )
                                              :
                                              //  SizedBox(width: 2,),

                                              Expanded(
                                                  child: OutlinedButton(
                                                      onPressed: () {},
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                            width: 2,
                                                            color: Colors.red),
                                                        shape: CircleBorder(),
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
                                            state.userData[index].user_role ??
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
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                      'Would you like to delete the user?'),
                                                                  Row(
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          BlocProvider.of<CheckUserStatusBloc>(context)
                                                                              .add(UserStatusDeleteEvent(userdata: User(id: state.userData[index].id)));

                                                                          if (checkState
                                                                              is DeletUserLoaded) {
                                                                            BlocProvider.of<GetUserDetailsListBloc>(context).add(GetUserDetailsEvent());
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              content: Text('User Deleted!'),
                                                                              duration: Duration(seconds: 1),
                                                                            ));
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              content: Text("User Couldn't beDeleted!"),
                                                                              duration: Duration(seconds: 1),
                                                                            ));
                                                                          }

                                                                          Navigator.pop(
                                                                              context,
                                                                              'Ok');
                                                                        },
                                                                        child: const Text(
                                                                            'OK'),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        CustomColors.red,
                                                    shape: CircleBorder(),
                                                    padding: EdgeInsets.all(5)),
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
                                                  value: state.userData[index]
                                                      .is_active!,
                                                  onChanged: (value) {
                                                    // value != isSwitched;
                                                    setState(() {
                                                      state.userData[index]
                                                          .is_active = value;
                                                    });

                                                    BlocProvider.of<
                                                                CheckUserStatusBloc>(
                                                            context)
                                                        .add(
                                                      UserStatusCheckEvent(
                                                        userdata: User(
                                                          is_active: value,
                                                          id: state
                                                              .userData[index]
                                                              .id,
                                                          is_suspended: state
                                                              .userData[index]
                                                              .is_suspended,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  activeTrackColor:
                                                      Colors.lightGreenAccent,
                                                  activeColor: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Suspend"),
                                              Center(
                                                child: Switch(
                                                  value: state.userData[index]
                                                      .is_suspended!,
                                                  onChanged: (value) {
                                                    // value != isSwitched;
                                                    setState(() {
                                                      state.userData[index]
                                                          .is_suspended = value;
                                                    });

                                                    BlocProvider.of<
                                                                CheckUserStatusBloc>(
                                                            context)
                                                        .add(UserStatusCheckEvent(
                                                            userdata: User(
                                                                is_active:
                                                                    value,
                                                                id: state
                                                                    .userData[
                                                                        index]
                                                                    .id,
                                                                is_suspended:
                                                                    value)));
                                                  },
                                                  activeTrackColor:
                                                      Colors.lightGreenAccent,
                                                  activeColor: Colors.green,
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
                      }),
                )),
              );
            });
          } else {
            return AppLoadingWidget();
          }
        },
      ),
    );
  }
}
