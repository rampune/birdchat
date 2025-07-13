import 'package:flutter/material.dart';
import 'package:work_manager/config/extensions.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.title,
      this.subTitle,
      this.dense = false,
      this.removePadding = false,
      this.enabled = true,
      this.controlAffinity = ListTileControlAffinity.leading,
      required this.resetNotifier});
  final String title;
  final Widget? subTitle;
  final bool dense;
  final bool removePadding;
  final bool enabled;
  final ListTileControlAffinity controlAffinity;
  final CustomCheckBoxNotifier resetNotifier;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.resetNotifier,
      builder: (BuildContext context, value, Widget? child) {
        return CheckboxListTile(
          enabled: widget.enabled,
          contentPadding:
              widget.removePadding ? EdgeInsets.zero : EdgeInsets.all(6),
          dense: widget.dense,
          value: value,
          onChanged: (value) {
            widget.resetNotifier.value = value!;
          },
          controlAffinity: widget.controlAffinity,
          title: Text(
            widget.title,
            style: context.bodyMedium(),
          ),
          subtitle: widget.subTitle,
        );
      },
    );
  }
}

class CustomCheckBoxNotifier extends ValueNotifier {
  CustomCheckBoxNotifier(value) : super(value);
  void reset() {
    value = false;
    notifyListeners();
  }
}
