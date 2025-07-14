import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/theme.dart';
class OutlineBtn extends StatelessWidget {
  const OutlineBtn({super.key,required this.title,this.icon});
  final String title;
  final IconData ?icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.darkGray)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Text(title,style: context.bodySmall(),),
        5.width(),
        Icon(icon)
      ],),
    );
  }
}
