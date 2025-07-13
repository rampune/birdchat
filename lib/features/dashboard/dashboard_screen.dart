import 'package:flutter/material.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/common_widgets/custom_bottom_navigation_bar.dart';
class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Text("Home")),

      body:  Column(children: [
        
        Text("Dashboard Screen")
      
      ],),
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
