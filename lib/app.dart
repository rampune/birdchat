import 'package:flutter/material.dart';
import 'package:work_manager/config/theme_data.dart';
import 'package:work_manager/data/source/local/hive_box.dart';
import 'package:work_manager/features/dashboard/dashboard_screen.dart';
import 'package:work_manager/features/intro/Intro_screen.dart';
import 'package:work_manager/features/login/view/mobile_login.dart';
import 'package:work_manager/test/socket_test.dart';

import 'config/navigation_util.dart';
import 'config/routes.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _getHome(),
    debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: theme,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorKey: NavigationUtil.navigatorKey,
    );
  }

  _getHome(){
    // return SocketTest();
    String ? isLogin=MyHiveBox.instance.getBox().get("login",defaultValue: null);
   return isLogin!=null?DashboardScreen(): MobileLogin();
    //return IntroScreen();
  }
}
