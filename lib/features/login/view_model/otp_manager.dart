import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class OtpManager{
  OtpManager._private();
static OtpManager instance=OtpManager._private();
factory OtpManager()=>instance;
   final FirebaseAuth auth = FirebaseAuth.instance;
  void verifyPhone({required String mobileNumber,required Function(String) onCodeSend,required Function onTimeout}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
 log("Phone number automatically verified and user signed in");
      },
      verificationFailed: (FirebaseAuthException e) {

        log("Verification failed: ${e.message}");

      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSend(verificationId);
        // setState(() {
        //   _verificationId = verificationId;
        //   _codeSent = true;
        // });
        log("Please check your phone for the OTP ${verificationId}");

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onTimeout();
      },
      timeout: const Duration(seconds: 60),
    );
  }

}