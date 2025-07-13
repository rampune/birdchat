import '../../config/common_functions.dart';


bool isValidMobileNumber(String mobileNumber) {
  RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if (mobileNumber.isEmpty) {
    return false;
  } else if ((mobileNumber.length < 10) ||
      (alphanumericRegEx.hasMatch(mobileNumber))) {
    return false;
  } else if (!regExp.hasMatch(mobileNumber)) {
    return false;
  } else if (mobileNumber == "0000000000") {
    return false;
  }
  return true;
}

bool isOnlyEnglish(String value) {
  final onlyHindi = RegExp(r'^[A-Za-z0-9 ]+$');
  return onlyHindi.hasMatch(value);
}

bool isOnlyHindi(String value) {
  final onlyHindi = RegExp(r'[a-zA-Z0-9]+');
  return onlyHindi.hasMatch(value);
}

String camelSentenceToWords(String text) {
  var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
  var finalResult = result[0].toUpperCase() + result.substring(1);
  return finalResult;
}
