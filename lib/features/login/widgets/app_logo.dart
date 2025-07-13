import 'package:flutter/material.dart';
import 'package:work_manager/config/assets.dart';
import 'package:work_manager/config/theme.dart';
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.themeColor,width: 2),
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(image: AssetImage(AppAssetsPath.logowb),
        fit: BoxFit.fill)
      ),

    );
  }
}
