import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';

import '../../../config/theme.dart';
import '../widgets/outline_btn.dart';
class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height(),
          Text("What's Your Party Style?",
            style: context.titleLarge(),),
          10.height(),
          Text("Choose your favourite music genres party types and crows vibes",
            style: context.bodyMedium()?.copyWith(
                color: AppColors.darkGray
            ),),
          10.height(),
          Text("Music Genres..."),
          10.height(),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              OutlineBtn(title: "Hip-Hop",icon: Icons.add,),

              OutlineBtn(title: "Retro/90s",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Jazz",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "POP",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Rock",icon: Icons.add,),

            ],),
          10.height(),
          Text("Party Types..."),
          10.height(),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              OutlineBtn(title: "DJ Night",icon: Icons.add,),

              OutlineBtn(title: "Pub Crawl",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Rooftop Party",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Sundower",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Coktail Night",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Couple Firendly",icon: Icons.add,),
              10.width(),
              OutlineBtn(title: "Young & Tredy",icon: Icons.add,)
            ],)
        ],),
    );;
  }
}
