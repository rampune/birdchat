import 'package:flutter/material.dart';

import 'package:work_manager/config/extensions.dart';

import '../../config/theme.dart';

Widget customOutlinedButton(
    {required BuildContext context,
    required String text,
    required Function() callback,
    Color? borderColor}) {
  return SafeArea(
    bottom: true,
    child: OutlinedButton(
        style: ButtonStyle(
            side: WidgetStateProperty.all(
                BorderSide(color: borderColor ?? AppColors.themeColor))),
        onPressed: callback,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: context.bodyMedium(),
            textAlign: TextAlign.center,
          ),
        )),
  );
}
