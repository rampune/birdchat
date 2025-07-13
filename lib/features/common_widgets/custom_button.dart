import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';

import '../../config/theme.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.buttonColor,
      this.buttonTextColor = AppColors.white,
      required this.onPress,
      this.padding = const EdgeInsets.all(10),
      this.useFullWidth,
      this.cornerRadius,
      this.maxLines,
      this.id,
      this.textAlign,
      this.height});

  final void Function()? onPress;
  final String buttonText;
  final Color? buttonColor;
  final Color buttonTextColor;
  final EdgeInsets padding;
  final bool? useFullWidth;
  final double? cornerRadius;
  final double? height;
  final int? maxLines;
  final String? id;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return (useFullWidth ?? false)
        ? SizedBox(
            width: DeviceSize.screenWidth(context) - 40,
            height: height ?? 40,
            child: _getButton(context, id),
          )
        : _getButton(context, id);
  }

  _getButton(BuildContext context, id) {
    return ElevatedButton(
      key: ValueKey(id),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 6,
        backgroundColor: buttonColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Colors.white54
                : AppColors.themeColor),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(cornerRadius ?? AppSizes.buttonRadius),
        ),
      ),
      child: Text(
        buttonText,
        style: context
            .bodyMedium()
            ?.copyWith(fontSize: 15, color: buttonTextColor),
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
