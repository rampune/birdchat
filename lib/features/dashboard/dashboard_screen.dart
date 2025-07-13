import 'package:flutter/material.dart';
import 'package:work_manager/features/common_widgets/custom_view_pager.dart';
import 'package:work_manager/features/login/view/mobile_login.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Text("Home")),

      body:  Column(children: [Text("Dashboard Screen")],),
      
    );
  }
}
