import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/features/intro/widgets/outline_btn.dart';

import '../../../config/theme.dart';
import '../../common_widgets/custom_text_field.dart';
class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        10.height(),
        Text("Add a Face to the Vibe.",
          style: context.titleLarge(),),
        10.height(),
        Text("Upload a photo so others can recoginze and connect with at events",
          style: context.bodyMedium()?.copyWith(
              color: AppColors.darkGray
          ),),
        10.height(),
       Text("Upload Profile Pic"),
          10.height(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            width: 100,height: 100,
            decoration: BoxDecoration(
      border: Border.all(color: AppColors.darkGray,),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.camera_alt,size: 70,),

          ),
          10.height(),
          Text("You Might Like to Party"),
          10.height(),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
            OutlineBtn(title: "Pune",icon: Icons.add,),

            OutlineBtn(title: "Mumbai",icon: Icons.add,),
            10.width(),
            OutlineBtn(title: "Banglore",icon: Icons.add,),
            10.width(),
            OutlineBtn(title: "Delhi",icon: Icons.add,),
            10.width(),
            OutlineBtn(title: "Kolkata",icon: Icons.add,),
            10.width(),
            OutlineBtn(title: "Ahmdabad",icon: Icons.add,)
          ],)
      ],),
    );
  }
}
