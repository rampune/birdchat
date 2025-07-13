import 'package:flutter/material.dart';

import 'overlay_loading_progress.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.body,
      this.appBar,
      this.floatingActionButton,
      this.bottomNavigationBar});

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        body: PopScope(onPopInvokedWithResult: (bool didPop, Object? result) {
          OverlayLoadingProgress.stop();
        }, child: body??SizedBox()));
  }
}
