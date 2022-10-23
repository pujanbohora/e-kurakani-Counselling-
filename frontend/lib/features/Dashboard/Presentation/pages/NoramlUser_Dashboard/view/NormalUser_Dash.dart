import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';

import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/features/Dashboard/Presentation/bloc/dashboard_bloc.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_category_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_sub_category_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_detail_page.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../../../core/utils/image_constants.dart';

class NormalUserDashboard extends StatefulWidget {
  const NormalUserDashboard({Key? key}) : super(key: key);

  @override
  State<NormalUserDashboard> createState() => _NormalUserDashboardState();
}

class _NormalUserDashboardState extends State<NormalUserDashboard> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(GetCustomerDashboardEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is CustomerDashboardLoadedState) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120.0, vertical: 18),
                              child: Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(ImageConst.LOGO),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      OurserviceText(),
                      AppGrideMenu(
                        categories: state.customerDashboardData.categories,
                      ),
                      HeadlineRecommendation(),
                      Recommnedationslider(
                        counsellors: state.customerDashboardData.counsellors,
                      ),
                    ],
                  ),
                );
              } else if (state is CustomerDashboardFailedState) {
                return const Center(
                  child: Text('Fetching data...'),
                );
              } else {
                return AppLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

class Recommnedationslider extends StatelessWidget {
  List<CounsellorProfileModel?>? counsellors;
  Recommnedationslider({
    Key? key,
    this.counsellors,
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
      'Dr. Esthanol Prajapati\nCardiologist Specialist',
      'Alpha Beta\nEducation',
      'hi',
      'Business',
      'Yoga',
      'Marriage'
    ];
    return Container(
        height: 180,
        child: ListView.builder(
            itemCount: counsellors!.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: CreateRequestViewCounsellorDetailScreen(
                      counsellorData: counsellors![index],
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 24),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              counsellors![index]!.user!.profile_image != null
                                  ? NetworkImage(
                                      counsellors![index]!.user!.profile_image!)
                                  : const AssetImage(
                                      "assets/images/counsellor_profile_image.jpeg",
                                    ) as ImageProvider,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          counsellors![index]!.name != null
                              ? counsellors![index]!.name!
                              : "N/A",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 136, 136, 136),
                              fontWeight: FontWeight.w900),
                        ),
                      ]),
                ),
              );
            }));
  }
}

class HeadlineRecommendation extends StatelessWidget {
  const HeadlineRecommendation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: const [
          Text(
            "Our Recommendations",
            style: TextStyle(
              color: Color.fromARGB(255, 123, 123, 123),
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class AppGrideMenu extends StatelessWidget {
  List<AddCategoryModel?>? categories;
  AppGrideMenu({
    Key? key,
    this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = [
      {"color": Color(0xffFF496B)},
      {"color": Color(0xff2972FE)},
      {"color": Color(0xff8EE071)},
      {"color": Color(0xffA5A6F6)},
      {"color": Color(0xff27C8EB)},
      {"color": Color(0xffF178B6)}
    ];

    List<String> imgs = [
      'assets/images/medicinal.png',
      'assets/images/education.png',
      'assets/images/plants.png',
      'assets/images/business.png',
      'assets/images/yoga.png',
      'assets/images/marriage.png',
    ];

    List<String> name = [
      'Medicinal',
      'Education',
      'Plants',
      'Business',
      'Yoga',
      'Marriage'
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              pushNewScreen(
                context,
                screen: CreateRequestSubCategoryViewScreen(
                  subCategoryListData: categories![index]!.children,
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: GestureDetector(
                child: Card(
              color: data[index]["color"],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: categories![index]!.image != null
                            ? Image.network(
                                categories![index]!.image!,
                                height: 45,
                                width: 50,
                              )
                            : Image.asset(
                                "assets/images/counsellor_profile_image.jpeg",
                                height: 45,
                                width: 50,
                              ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        name[index],
                        style: TextStyle(
                            fontSize: 13,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ]),
              ),
            )),
          );
        },
      ),
    );
  }
}

class OurserviceText extends StatelessWidget {
  const OurserviceText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            const Text(
              "Our Services",
              style: TextStyle(
                color: Color.fromARGB(255, 123, 123, 123),
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: CreateRequestCategoryViewScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                "View all",
                style: TextStyle(
                  color: CustomColors.primaryBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ));
  }
}

class Seachbar extends StatelessWidget {
  const Seachbar({
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
              hintText: '  Search your professionals...',
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
