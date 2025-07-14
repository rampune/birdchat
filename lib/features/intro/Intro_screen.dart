import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/routes.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/common_widgets/custom_button.dart';
import 'package:work_manager/features/common_widgets/custom_view_pager.dart';
import 'package:work_manager/features/intro/fragments/intro1.dart';
import 'package:work_manager/features/intro/fragments/intro2.dart';
import 'package:work_manager/features/intro/fragments/intro3.dart';
class IntroScreen extends StatelessWidget {
   IntroScreen({super.key});
PageController pageController=PageController();
int screen=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SmoothPageIndicator(
              controller: pageController,
              count:  3,
              axisDirection: Axis.horizontal,
              effect:  SlideEffect(
                  spacing:  8.0,
                  radius:  4.0,
                  dotWidth:  100,
                  dotHeight:  16.0,
                  paintStyle:  PaintingStyle.stroke,
                  strokeWidth:  1.5,
                  dotColor:  Colors.grey,
                  activeDotColor:  AppColors.themeColor
              ),
            ),
            Expanded(
              child: CustomViewPager(callBack: (int index){},
                  listScreens: [
                    Intro1(),
                    Intro2(),
                    Intro3()

                  ], controller: pageController),
            ),
            10.height(),

            SizedBox(
                width: double.infinity,
                child: CustomButton(buttonText: "NEXT",
                    onPress: (){
                        screen++;
                        if(screen==3){
                          Navigator.pushNamed(context, AppRoutes.dashboardScreen);
                        }
                        pageController.animateToPage(
                          screen,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                })),
            // ElevatedButton(onPressed: (){
            //   screen++;
            //   pageController.animateToPage(
            //     screen,
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.easeInOut,
            //   );
            //
            // }, child: Text("NEXT"))

          ],
        ),
      ),
      ),
    );
  }
}
