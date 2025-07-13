import 'package:flutter/material.dart';
import 'package:work_manager/features/dashboard/dashboard_screen.dart';

class AppRoutes {
  static const String home="/";
static const String dashboardScreen="/dashboardScreen";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    case dashboardScreen:
        return CustomPageRoute(builder: (_)=>DashboardScreen(), settings: settings);
      case home:

        return CustomPageRoute(builder: (_)=>DashboardScreen(), settings: settings);

      default:
        return CustomPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
            settings: settings);
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute)
    //   return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return new FadeTransition(opacity: animation, child: child);

    return new SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
