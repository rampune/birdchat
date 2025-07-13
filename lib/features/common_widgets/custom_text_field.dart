import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_manager/config/extensions.dart';

import '../../config/theme.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.isPassword = false,
      this.isNumber = false,
      this.length,
      this.textCapitalization = TextCapitalization.none,
      required this.textController,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.cornerRadius,
      this.title,
      this.placeHolderText,
      this.textAlign,
      this.prefixText,
      this.prefix,
      this.textInputAction,
      this.id,
      this.lines,
      this.minLines,
      this.focusNode,
      this.showCounterText = false,
      this.suffix,
      this.readOnly = false,
      this.onTap,
      this.enabled = true,
      this.inputFormatters});

  final Function()? onTap;
  final bool readOnly;
  final bool isPassword;
  final String? title;
  final String? placeHolderText;
  final bool isNumber;
  final bool enabled;
  final int? length;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;
  final TextEditingController textController;
  final int? lines;
  final int? minLines;
  final bool? showCounterText;
  final double? cornerRadius;
  final String? prefixText;
  final String? id;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<StatefulWidget> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  void initState() {
    setState(() {
      obscureText = widget.isPassword;
    });
    super.initState();
  }

  void visibilityTap() {
    setState(() {
      obscureText = obscureText == true ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        10.height(),
        widget.title != null
            ? Text(
                widget.title ?? "",
                style: context.bodyMedium(),
              )
            : const SizedBox.shrink(),
        TextFormField(
          key: ValueKey(widget.id),
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatters,
          /* buildCounter: (_,
                  {required currentLength, maxLength, required isFocused}) =>
              getCounter(currentLength, maxLength),*/
          style: CustomTextStyle.displayMedium(context),
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          validator: widget.validator,
          cursorColor: AppColors.textFieldBorderColor,
          maxLines: widget.lines == 0 ? null : widget.lines ?? 1,
          minLines: widget.minLines == 0 ? null : widget.minLines ?? 1,
          textAlign: widget.textAlign ?? TextAlign.start,
          textCapitalization: widget.textCapitalization,
          controller: widget.textController,
          maxLength: widget.length,
          textInputAction: widget.textInputAction,
          obscureText: obscureText,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.multiline,
          decoration: InputDecoration(
              hintText: widget.placeHolderText,
              counterText: (widget.showCounterText ?? false) ? null : '',
              prefixIcon: widget.prefix,
              hintStyle: context.bodyMedium(),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        visibilityTap();
                      },
                      icon: Icon(
                        obscureText == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )
                  : widget.suffix),
        )
      ],
    );
  }

  getCounter(currentLength, maxLength) {
    if (widget.showCounterText == true) {
      return Align(
          alignment: Alignment.centerRight,
          child: Text(
            "$currentLength/$maxLength",
            style: context.bodySmall(),
          ));
    }
    return null;
  }
}
