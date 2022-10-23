import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/features/Dashboard/Presentation/bloc/dashboard_bloc.dart';
import 'package:frontend/features/Dashboard/data/model/counsellor_dashboard_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/view/appointment_details.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/image_constants.dart';

class CounsellorDashboard extends StatefulWidget {
  const CounsellorDashboard({Key? key}) : super(key: key);

  @override
  State<CounsellorDashboard> createState() => _CounsellorDashboardState();
}

class _CounsellorDashboardState extends State<CounsellorDashboard> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(GetCounsellorDashboardEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.black,
        key: _scaffoldkey,
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is CounsellorDashboardLoadedState) {
                return Container(
                  // height: size.height,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 214, 240, 249),
                      Color.fromARGB(255, 243, 243, 243),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100.0, vertical: 18),
                              child: Container(
                                height: 35,
                                width: 150,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(ImageConst.LOGO))),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text("Your e-counselling Journey",
                              style: TextStyle(
                                color: Color.fromARGB(255, 123, 123, 123),
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ))),
                      BusinessDashCard(
                        cdrm: state.counsellorDashboardData,
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text("Your Schedule",
                              style: TextStyle(
                                color: Color.fromARGB(255, 123, 123, 123),
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ))),
                      ActiveCounsellorscroll(
                        cdrm: state.counsellorDashboardData,
                      )
                    ],
                  ),
                );
              } else if (state is CounsellorDashboardFailedState) {
                return const Center(
                  child: Text('Error while fetching data'),
                );
              } else {
                return AppLoadingWidget();
              }
            },
          ),
        )));
  }
}

class ActiveCounsellorscroll extends StatelessWidget {
  CounsellorDashboardResponseModel? cdrm;
  ActiveCounsellorscroll({
    this.cdrm,
    Key? key,
  }) : super(key: key);
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  Widget build(BuildContext context) {
    List<String> recommendimgs = [
      'assets/images/i.png',
      'assets/images/i.png',
      'assets/images/i.png',
      'assets/images/i.png',
    ];

    List<String> recommendname = [
      'Dr.Risk',
      'Dr.Strange',
      'hi',
      'Business',
      'Yoga',
      'Marriage'
    ];
    return Container(
        height: 200,
        child: ListView.builder(
            itemCount: cdrm!.appointments!.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 25),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  UserModel? userInfo =
                      await signUpLocalDataSource.getUserDataFromLocal();
                  print(userInfo);
                  print(cdrm!.appointments![index]);
                  pushNewScreen(
                    context,
                    screen: AppointmentDetails(
                      appointmentData: cdrm!.appointments![index],
                      userData: userInfo,
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
                  width: 180,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    border: Border.all(
                      color: CustomColors.lightGrey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 182, 182, 182).withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 2,
                        // offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: cdrm!
                                  .appointments![index].user!.profile_image !=
                              null
                          ? NetworkImage(
                              cdrm!.appointments![index].user!.profile_image!)
                          : const AssetImage(
                              "assets/images/counsellor_profile_image.jpeg",
                            ) as ImageProvider,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        cdrm!.appointments![index].user!.details!.full_name !=
                                null
                            ? cdrm!
                                .appointments![index].user!.details!.full_name!
                            : "N/A",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 117, 117, 117),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        'Time: ${cdrm!.appointments![index].time != null ? cdrm!.appointments![index].time! : "N/A"}',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 117, 117, 117),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }));
  }
}

class BusinessDashCard extends StatelessWidget {
  CounsellorDashboardResponseModel? cdrm;
  BusinessDashCard({
    this.cdrm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List colordata = [
      {"color": Color(0xff2972FE)},
      {"color": Color(0xff2972FE)},
      {"color": Color(0xff2972FE)},
      {"color": Color(0xff2972FE)},

      //  {"color": Color.fromARGB(255, 255, 42, 81)},
      //  {"color": Color(0xff2972FE)},
      //  {"color": Color.fromARGB(255, 141, 228, 110)},
      //  {"color": Color(0xffA5A6F6)},
    ];

    List<String> name = [
      'Balance',
      'Feedbacks',
      'Past Appointment',
      'Upcoming Appointment'
    ];

    List<String> numbers = [
      cdrm!.collected_balance.toString(),
      cdrm!.feedback_count.toString(),
      cdrm!.past_appointment_count.toString(),
      cdrm!.upcoming_appointment_count.toString(),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
        ),
        itemCount: colordata.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
                margin: EdgeInsets.only(top: 10),
                color: colordata[index]["color"],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        numbers[index],
                        style: TextStyle(
                            fontSize: 30,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 5),
                      Text(
                        name[index],
                        style: TextStyle(
                            fontSize: 15,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            border: Border.all(color: CustomColors.lightGrey),
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffFFFFFF)
            // color: CustomColors.lightGrey
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
          child: TextField(
            cursorHeight: 24,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 22.5,
                color: CustomColors.black,
              ),
              prefixIconConstraints: BoxConstraints(maxHeight: 20),
              hintText: '  Search your counsellors...',
              hintStyle: TextStyle(fontSize: 16),
              contentPadding: EdgeInsets.only(bottom: 5),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
