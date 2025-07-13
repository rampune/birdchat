import 'dart:developer';

import 'package:flutter/material.dart';

import 'common_widget.dart';

Widget networkImage(
    {required String serverUrl,
    required Widget errorWidget,
    Map<String, String>? headers}) {
  log(headers.toString());
  return Image.network(
    serverUrl,
    headers: headers,
    loadingBuilder:
        (BuildContext context, Widget image, ImageChunkEvent? loadingProgress) {
      return loadingProgress == null ? image : progressIndicator(context);
    },
    errorBuilder: (context, error, stackTrace) {
      log(error.toString());
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: errorWidget,
      );
    },
    fit: BoxFit.cover,
  );
}
