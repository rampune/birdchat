import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/features/common_widgets/custom_text_field.dart';
import 'package:work_manager/features/intro/introController.dart';
import 'package:work_manager/features/intro/widgets/outline_btn.dart';
class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      10.height(),
         Text("Let's Get to Know You.",
         style: context.titleLarge(),),
      10.height(),
          Text("Build your profile and discover the best nightlife experiences tailored to you.",
            style: context.bodyMedium()?.copyWith(
              color: AppColors.darkGray
            ),),
          10.height(),
          CustomTextField(textController: IntroController.name,title: "Your Name",),
          10.height(),
          CustomTextField(textController: IntroController.datePicker,title: "Your Birthday",
          placeHolderText: "Select Birthday",
            readOnly: true,
            onTap: ()async{
              IntroController.datePicker.text= await _selectDate(context);
            },
          ),
          10.height(),
          Text("Gender"),
          10.height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(child: OutlineBtn(title: "MALE",icon: Icons.male,)),
              20.width(),
              Expanded(child: OutlineBtn(title: "FEMALE",icon: Icons.female,)),
          ],),
          10.height(),
          Text("Drinking Habbit"),
          10.height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: OutlineBtn(title: "Yes, I drink",icon: Icons.add,)),
              20.width(),
              Expanded(child: OutlineBtn(title: "No, I don't drink",icon: Icons.close,)),
            ],),

          10.height(),
          Text("Smoking Habbit"),
          10.height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: OutlineBtn(title: "Yes, I Smoke",icon: Icons.add,)),
              20.width(),
              Expanded(child: OutlineBtn(title: "No, I don't smoke",icon: Icons.close,)),
            ],),



      ],),
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if(pickedDate==null){
      return "Select Birthday";
    }
return "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";

  }
}
