import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';

Widget customTextButton(
    {required BuildContext context,
    required String text,
    required Function() callback,
    double? width,
    Alignment alignment = Alignment.center,
    double? height}) {
  return InkWell(
      onTap: callback,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: context.bodyMedium()?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ).sizedBox(height: height, width: width));
}
