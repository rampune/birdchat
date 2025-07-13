import 'package:flutter/material.dart';
import 'package:work_manager/config/navigation_util.dart';

import 'overlay_loading_progress.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.automaticallyImplyLeading,
      required this.title,
      this.leading,
      this.actions,
      this.bottom});

  final String title;
  final bool? automaticallyImplyLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: automaticallyImplyLeading ?? true
          ? (leading ??
              BackButton(
                onPressed: () {
                  OverlayLoadingProgress.stop();
                  context.pop();
                },
              ))
          : null,
      actions: actions,
      title: Text(
        title,
        overflow: TextOverflow.fade,
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
