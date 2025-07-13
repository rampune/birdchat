import 'package:flutter/material.dart';

Widget dropDownArrow() {
  return const Icon(
    Icons.arrow_drop_down,
    size: 25,
  );
}

// Widget LoaderWidget({
//   required BuildContext context,
//   required bool visible,
// }) {
//   return Visibility(
//       visible: visible,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 24),
//         child: Center(
//           child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).dialogBackgroundColor,
//                 borderRadius: const BorderRadius.all(Radius.circular(12)),
//               ),
//               child: Center(
//                   child: CircularProgressIndicator(
//                       strokeWidth: 1, color: Theme.of(context).primaryColor))),
//         ),
//       ));
// }

Widget progressIndicator(context, {double? width, double? height}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      strokeWidth: 1,
      color: Theme.of(context).primaryColor,
    ),
  );
}
