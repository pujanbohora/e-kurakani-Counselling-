import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/features/Dashboard/Presentation/bloc/dashboard_bloc.dart';
import 'package:frontend/features/Dashboard/data/model/business_dashboard_response_model.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/image_constants.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({Key? key}) : super(key: key);

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(GetBusinessDashboardEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is BusinessDashboardLoadedState) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 214, 240, 249),
                      Color.fromARGB(255, 243, 243, 243),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(ImageConst.LOGO))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Text("Your e-counselling Journey",
                              style: TextStyle(
                                color: Color.fromARGB(255, 123, 123, 123),
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ))),
                      BusinessDashCard(
                        bdrm: state.businessDashboardData,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Text("Your Active Counsellors",
                              style: TextStyle(
                                color: Color.fromARGB(255, 123, 123, 123),
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ))),
                      ActiveCounsellorscroll(
                        bdrm: state.businessDashboardData,
                      )
                    ],
                  ),
                );
              } else if (state is BusinessDashboardFailedState) {
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
  BusinessDashboardResponseModel? bdrm;
  ActiveCounsellorscroll({
    this.bdrm,
    Key? key,
  }) : super(key: key);

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
      height: 165,
      child: ListView.builder(
        itemCount: bdrm!.counsellors!.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 25),
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(
                color: CustomColors.lightGrey,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 182, 182, 182).withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 2,
                  // offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        bdrm!.counsellors![index].user!.profile_image != null
                            ? NetworkImage(
                                bdrm!.counsellors![index].user!.profile_image!)
                            : const AssetImage(
                                "assets/images/counsellor_profile_image.jpeg",
                              ) as ImageProvider,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      bdrm!.counsellors![index].name != null
                          ? bdrm!.counsellors![index].name!
                          : "N/A",
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 117, 117, 117),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}

class BusinessDashCard extends StatelessWidget {
  BusinessDashboardResponseModel? bdrm;
  BusinessDashCard({
    this.bdrm,
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
      'Counselling',
      'Appointment',
      'Counsellors'
    ];

    List<String> numbers = [
      bdrm!.collected_balance.toString(),
      bdrm!.feedback_count.toString(),
      bdrm!.total_appointment.toString(),
      bdrm!.total_counsellor.toString(),
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
                        style: const TextStyle(
                            fontSize: 35,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        name[index],
                        style: const TextStyle(
                            fontSize: 18,
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
