import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/profile/profile_screen.dart';
import 'package:tech_media/view/dashboard/user/user_list_screen.dart';
import 'package:tech_media/view_model/services/session_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      Text("Home"),
      Text("Chat"),
      Text("Add"),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
          ),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.home,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.message_outlined,
          ),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.message_outlined,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.add,
          ),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.add,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
          ),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.home,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
          ),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.person,
            color: Colors.grey.shade100,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        screens: _buildScreen(),
        items: _navBarItems(),
        navBarStyle: NavBarStyle.style15,
        backgroundColor: AppColors.otpHintColor,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
