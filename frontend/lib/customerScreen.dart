import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/features/Dashboard/Presentation/pages/NoramlUser_Dashboard/view/NormalUser_Dash.dart';
import 'package:frontend/features/appointment/past_appointments/presentation/pages/user_past_appointment_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_category_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_request_for_appointment_view_page.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_detail_page.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/view/customer_appointments_list.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/change_password_page.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/userprofile.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/view_account_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CustomerScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final UserModel? userInfo;
  const CustomerScreen(
      {Key? key, required this.menuScreenContext, required this.userInfo})
      : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _hideNavBar = false;

  List<Widget> _buildScreens() {
    return [
      // const CreateRequestCategoryViewScreen(),
      NormalUserDashboard(),
      CustomerAppointmentsList(),
      UserPastAppointmentScreen(
        userModel: widget.userInfo,
      ),
      ViewAccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.homeOutline),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group_outlined),
        title: "Appointment",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: "History",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/profile",
          routes: {
            "/edituser-profile": (context) => EditProfilePage(),
            "/change-password": (context) => ChangePasswordScreen(),
          },
        ),
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
