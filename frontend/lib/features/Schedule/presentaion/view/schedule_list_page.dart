import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/Schedule/domain/entities/schedule_week_entities.dart';
import 'package:frontend/features/Schedule/presentaion/bloc/schedule_list_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/add_counsellor_schedule.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/add_counsellor_timetable_page.dart';
import 'package:frontend/injectable.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ScheduleListScreen extends StatefulWidget {
  ScheduleListScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  final CarouselController carouselController = CarouselController();

  List<int> featuredImage = [1, 2, 3, 4];
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ScheduleListBloc>(context).add(GetScheduleListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScheduleListBloc>(context).add(GetScheduleListEvent());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE4F2F7),
      appBar:
          appBar(noBackButton: true, navTitle: "Schedule", backNavigate: () {}),
      body: SafeArea(
        child: BlocBuilder<ScheduleListBloc, ScheduleListState>(
            builder: (context, state) {
          if (state is GetScheduleListLoadedState) {
            if (state.scheduleWeekEntities.isEmpty) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          UserModel? userInfo = await signUpLocalDataSource
                              .getUserDataFromLocal();
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: AddCounsellorScheduleScreen(
                              userId: userInfo!.id,
                            ),
                            settings: const RouteSettings(
                              name: Routes.SCHEDULE_LIST_SCREEN,
                            ),
                          );
                        },
                        child: const Text(
                          'Add Schedule',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          UserModel? userInfo = await signUpLocalDataSource
                              .getUserDataFromLocal();
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: AddCounsellorTimeTableScreen(
                              userId: userInfo!.id,
                            ),
                            settings: const RouteSettings(
                              name: Routes.SCHEDULE_LIST_SCREEN,
                            ),
                          );
                        },
                        child: Text(
                          'Add Month Schedule',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Center(child: Text("No Schedule Found")),
                ],
              );
            } else {
              return _buildBody(size, state.scheduleWeekEntities);
            }
            // state.scheduleWeekEntities.isEmpty ? Text("data") :
            //  _buildBody(size, state.scheduleWeekEntities);
            //  return
          } else if (state is GetScheduleListFailedState) {
            return const Center(
                child: Text(
              'No Schedule Found',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ));
          } else {
            return AppLoadingWidget();
          }
        }),
      ),
    );
  }

  _buildBody(Size size, List<ScheduleWeekEntities> state) {
    return Container(
      // color: Colors.amber,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // initialPage: 2,
              // autoPlay: true,
              aspectRatio: 0.66,
              enlargeCenterPage: false,
              viewportFraction: 1,
            ),
            carouselController: carouselController,
            items: state
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          Text(
                            e.week != null ? e.week! : "N/A",
                            // 'Jan 21, 2022',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              UserModel? userInfo = await signUpLocalDataSource
                                  .getUserDataFromLocal();
                              pushNewScreenWithRouteSettings(
                                context,
                                screen: AddCounsellorScheduleScreen(
                                  userId: userInfo!.id,
                                ),
                                settings: const RouteSettings(
                                  name: Routes.SCHEDULE_LIST_SCREEN,
                                ),
                              );
                            },
                            child: const Text(
                              'Add Schedule',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              UserModel? userInfo = await signUpLocalDataSource
                                  .getUserDataFromLocal();
                              pushNewScreenWithRouteSettings(
                                context,
                                screen: AddCounsellorTimeTableScreen(
                                  userId: userInfo!.id,
                                ),
                                settings: const RouteSettings(
                                  name: Routes.SCHEDULE_LIST_SCREEN,
                                ),
                              );
                            },
                            child: Text(
                              'Add Month Schedule',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: e.days!.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                // padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: const BoxDecoration(
                                              color: CustomColors.primary,
                                              border: Border(
                                                  right: BorderSide(
                                                width: 2,
                                              ))),
                                          width: size.width / 3,
                                          child: Center(
                                            child: Text(
                                              e.days![index].day != null
                                                  ? e.days![index].day!
                                                  : "N/A",

                                              // 'Sunday:',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.height * 0.01,
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          height: 50,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  e.days![index].time!.length,
                                              itemBuilder:
                                                  (context, int timeIndex) {
                                                return Row(
                                                  children: [
                                                    Text(
                                                      e
                                                          .days![index]
                                                          .time![timeIndex]
                                                          .start_time!,
                                                      textScaleFactor: 1.2,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const Text(
                                                      " - ",
                                                    ),
                                                    Text(
                                                      e
                                                          .days![index]
                                                          .time![timeIndex]
                                                          .end_time!,
                                                      textScaleFactor: 1.2,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Are you sure you want to remove this schedule?'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Row(
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      BlocProvider.of<ScheduleListBloc>(
                                                                              context)
                                                                          .add(
                                                                        DeleteScheduleEvent(
                                                                          id: e
                                                                              .days![index]
                                                                              .time![timeIndex]
                                                                              .id!
                                                                              .toString(),
                                                                        ),
                                                                      );
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Ok');
                                                                    },
                                                                    child: const Text(
                                                                        'Yes'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  // Use the controller to change the current page
                  carouselController.previousPage();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  // Use the controller to change the current page
                  carouselController.nextPage();
                },
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
