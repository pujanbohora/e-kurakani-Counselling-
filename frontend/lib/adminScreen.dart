import 'package:flutter/material.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/auth/user/presentation/pages/userlist/userlist.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/view_account_page.dart';
import 'package:frontend/features/category/presentation/pages/add_category/view/add_category_page.dart';
import 'package:frontend/features/category/presentation/pages/admin_view_category_page.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/profilerequest_list.dart';
import 'package:frontend/features/report/presentation/view/report_view.dart';
import 'package:frontend/features/report/presentation/view/view_feedback_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AdminScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final UserModel? userInfo;
  const AdminScreen({
    Key? key,
    required this.menuScreenContext,
    required this.userInfo,
  }) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _hideNavBar = false;

  List<Widget> _buildScreens() {
    return [
      ProfilerequestList(),
      ViewCategoryScreen(),
      ReportViewScreen(),
      FeedbackViewScreen(),
      UserList(),
      ViewAccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      navListingItems(icon: Icon(Icons.home), title: "Home"),
      navListingItems(icon: Icon(Icons.category), title: "Category"),
      navListingItems(icon: Icon(Icons.report), title: "Report"),
      navListingItems(icon: Icon(Icons.feedback_rounded), title: "Feedback"),
      navListingItems(icon: Icon(Icons.group_outlined), title: "Users"),
      navListingItems(icon: Icon(Icons.settings), title: "Setting"),
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
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(20.0)),
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

  PersistentBottomNavBarItem navListingItems({Widget? icon, String? title}) {
    return PersistentBottomNavBarItem(
      icon: icon!,
      title: title,
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    );
  }
}
