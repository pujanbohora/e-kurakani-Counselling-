import 'package:flutter/material.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/BusinessUser_Dashboard/view/BusinessUser_Dash.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/CounsellorUser_Dasboard/view/CounsellorUser_Dash.dart';
import 'package:frontend/features/appointment/past_appointments/presentation/pages/user_past_appointment_page.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/view/appointments_list.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/pages/create_counsellor/list_counsellor_page.dart';
import 'package:frontend/features/auth/create_counsellor/presentation/pages/create_counsellor/view/create_counsellor_screen.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/view_account_page.dart';
import 'package:frontend/features/profiles/presentation/pages/counsellor_profile/view/add_counsellor_timetable_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BusinessScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final UserModel? userInfo;
  const BusinessScreen({
    Key? key,
    required this.menuScreenContext,
    required this.userInfo,
  }) : super(key: key);

  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _hideNavBar = false;

  List<Widget> _buildScreens() {
    return [
      BusinessDashboard(),
      AppointmentsList(),
      CounsellorList(),
      UserPastAppointmentScreen(
        userModel: widget.userInfo,
      ),
      const ViewAccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book_online),
        title: "Appointment",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.people_outline),
        title: "Counsellors",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: "History",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        hideNavigationBar: _hideNavBar,
        // decoration: NavBarDecoration(
        //     colorBehindNavBar: Colors.indigo,
        //     borderRadius: BorderRadius.circular(20.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style3, // Choose the nav bar style with this property
      ),
    );
  }
}
