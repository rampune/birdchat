import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:work_manager/features/common_widgets/custom_view_pager.dart';
import 'package:work_manager/features/fragments/chat_fragment.dart';
import 'package:work_manager/features/fragments/live_fragment.dart';
import 'package:work_manager/services/socket_service.dart';
class DashboardScreen extends StatefulWidget {
   DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController pageController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomViewPager(callBack: (int index){}, listScreens: [
        LiveFragment(),
        ChatFragment(),


      ], controller: pageController),
      bottomNavigationBar: CustomBottomNavigationBar(callBack: (int index){},
      listBottomItem: [
        BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Chat",backgroundColor: AppColors.black),
        BottomNavigationBarItem(icon: Icon(Icons.online_prediction),label: "Online"),
        BottomNavigationBarItem(icon: Icon(Icons.get_app),label: "Friend request"),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
      ],),
    );
  }
}
