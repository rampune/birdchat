import 'package:flutter/material.dart';

class CustomViewPager extends StatelessWidget {
  const CustomViewPager(
      {super.key,
      required this.callBack,
    required  this.listScreens,
      required this.controller});
  final Function(int) callBack;
  final List<Widget> listScreens;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: (index) {
        print(index.toString());
        callBack(index);
      },
      children: listScreens
    );
  }
}
