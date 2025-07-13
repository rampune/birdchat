import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:work_manager/config/theme.dart';


RegExp alphanumericRegEx = RegExp(r'[^a-zA-Z0-9 ]');

String getCurrentDate() {
  return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()).toString();
}

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  final Uri launchUri = Uri.parse(googleUrl);
  await launchUrl(launchUri, mode: LaunchMode.externalApplication);
}






Future<void> dialNumber(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> openUrl(String url, {bool? isLaunchModeApp = false}) async {
  final Uri launchUri = Uri.parse(url);
  await launchUrl(launchUri,
      mode: isLaunchModeApp == true
          ? LaunchMode.inAppWebView
          : LaunchMode.externalApplication);
}



void showAlert(BuildContext context, String message,
    {Function()? callback,
    EdgeInsets? insetPadding,
    bool barrierDismissible = false}) {
  Future.delayed(Duration.zero, () {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => PopScope(
              canPop: barrierDismissible,
              onPopInvokedWithResult: (bool didPop, Object? result) {
                if (didPop) return;
              },
              child: AlertDialog(
                insetPadding: insetPadding,
                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                surfaceTintColor: AppColors.themeColor,
                content: Text(
                  message,

                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Center(
                    child: ElevatedButton(
                      key: ValueKey('yes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor, // background
                        // foreground
                      ),
                      onPressed: callback ??
                          () {

                          },
                      child: Text(

                        "strAppOK",
                      ),
                    ),
                  ),
                ],
              ),
            ));
  });
}

void showAlertAndPop(BuildContext context, String message,
    {Function()? callback}) {
  Future.delayed(Duration.zero, () {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                surfaceTintColor: AppColors.themeColor,
                content: Text(
                  message,

                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Center(
                    child: ElevatedButton(
                      key: ValueKey('yes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor, // background
                        // foreground
                      ),
                      onPressed: callback ??
                          () {

                          },
                      child: Text(

                        "strAppOK",
                      ),
                    ),
                  ),
                ],
              ),
            ));
  });
}




// hide keyboard whenever needed
void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isImage(String fileExtension) {
  return ['png', 'jpg', 'jpeg', 'bmp', 'bitmap', 'gif'].contains(fileExtension);
}

MimeTypeRajCop getMimeType(String mimeType) {
  if (mimeType.endsWith('.jpg') ||
      mimeType.endsWith('.jpeg') ||
      mimeType.endsWith('.png') ||
      mimeType.endsWith('.bmp')) {
    return MimeTypeRajCop.IMAGE;
  } else if (mimeType.endsWith('.mp4') ||
      mimeType.endsWith('.mpeg') ||
      mimeType.endsWith('.mpe') ||
      mimeType.endsWith('.mpg') ||
      mimeType.endsWith('.mpg4') ||
      mimeType.endsWith('.m4v') ||
      mimeType.endsWith('.mov')) {
    return MimeTypeRajCop.VIDEO;
  }
  return MimeTypeRajCop.NONE;
}



enum MimeTypeRajCop { VIDEO, IMAGE, TEXT, NONE }

String getGenderByCode(code, {String lang = 'hi'}) {
  String strGender = '';
  switch (code) {
    case 1:
      strGender = lang == 'hi' ? "हिजड़ा" : 'Transgender';
      break;
    case 2:
      strGender = lang == 'hi' ? "स्त्री" : 'Female';
      break;
    case 3:
      strGender = lang == 'hi' ? "पुरुष" : 'Male';
      break;
    case 4:
      strGender = lang == 'hi' ? "अन्य" : 'Unknown';
      break;
  }
  return strGender;
}

String getGenderCodeByGenter(String gender) {
  String strGenderCd = '';
  switch (gender.toLowerCase().trim()) {
    case 'transgender':
      strGenderCd = '1';
      break;
    case 'female':
      strGenderCd = '2';
      break;
    case 'male':
      strGenderCd = '3';
      break;
    case 'unknown':
      strGenderCd = '4';
      break;
  }
  return strGenderCd;
}



enum EnumOfficeType {
  none,
  CircleOffice,
  CIDOffice,
  RangeOffice,
  DistrictOffice,
  PoliceStation
}





Widget getTitleWithAction(
    {required BuildContext ctx,
    required String title,
    Function()? callBack,
    double? bottomSpace,
    double? topSpace,
    String? boldText,
    TextStyle? style,
    Color? color}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomSpace ?? 0.0, top: topSpace ?? 0.0),
    child: InkWell(
      onTap: callBack ?? null,
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            new TextSpan(
                text: boldText,
                style: style?.copyWith(
                  color: color == null
                      ? Theme.of(ctx).brightness == Brightness.light
                          ? AppColors.themeColor
                          : AppColors.white
                      : color,
                  fontSize: style.fontSize,
                  fontWeight: FontWeight.w800,
                )),
            TextSpan(
                text: title,
                style: style?.copyWith(
                  color: color == null
                      ? Theme.of(ctx).brightness == Brightness.light
                          ? AppColors.themeColor
                          : AppColors.white
                      : color,
                  fontSize: style.fontSize,
                ))
          ],
        ),
      ),
    ),
  );
}

String getFileNameFromPath(String filePath) {
  String fileName = '';
  var pathForwardSlash = filePath.split('/');
  if (pathForwardSlash.length > 1) {
    fileName = pathForwardSlash.last;
  }
  if (fileName.isEmpty) {
    var pathBackwardSlash = filePath.split('\\');
    if (pathBackwardSlash.length > 1) {
      fileName = pathBackwardSlash.last;
    }
  }
  return fileName;
}


Future<bool> isInternetAvailable() async {
  try {
    final foo = await InternetAddress.lookup('google.com');
    return foo.isNotEmpty && foo[0].rawAddress.isNotEmpty ? true : false;
  } catch (e) {
    return false;
  }
}
