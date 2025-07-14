import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_manager/config/assets.dart';
import 'package:work_manager/config/extensions.dart';
import 'package:work_manager/config/routes.dart';
import 'package:work_manager/config/theme.dart';
import 'package:work_manager/data/source/local/hive_box.dart';
import 'package:work_manager/features/common_widgets/custom_button.dart';
import 'package:work_manager/features/common_widgets/custom_scaffold.dart';
import 'package:work_manager/features/common_widgets/custom_text_field.dart';
import 'package:work_manager/features/login/view_model/otp_manager.dart';
import 'package:work_manager/features/login/widgets/app_logo.dart';
import 'package:work_manager/features/login/widgets/controllers.dart';
class MobileLogin extends StatelessWidget {
  const MobileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          10.height(),
          Text("Sign Up/In in bird Chat",style: context.titleLarge()?.copyWith(
            fontWeight: FontWeight.bold
          ),),
        10.height(),
        Align(alignment: Alignment.center,
           child:  AppLogo()
        ),

          10.height(),
          Text("BIRD CHAT",style: context.titleLarge()?.copyWith(
            color: AppColors.themeColor,
            fontWeight: FontWeight.bold
          ),),
          10.height(),


          CustomTextField(textController: LoginController.mobileNumber,
          prefix: SizedBox(
              width: 100,
              child: Center(child: Text(" 🇮🇳 +91",))),
            title: "Enter Mobile Number",
            placeHolderText: "Enter Mobile Number",
            length: 10,
            isNumber: true,
          ),
          10.height(),
          SizedBox(
              width: double.infinity,
              child: CustomButton(buttonText: "SEND OTP", onPress: (){
                OtpManager.instance.verifyPhone(mobileNumber: "+91${LoginController.mobileNumber.text}",
                    onCodeSend: (String id)async{
                      PhoneAuthCredential credential=    PhoneAuthProvider.credential(
                        verificationId: id,
                        smsCode: "123456",
                      );
                      try {
                        OtpManager.instance.auth.signInWithCredential(credential);


                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Phone number verified and user signed in")),
                        );

                        MyHiveBox.instance.getBox().put("login","${LoginController.mobileNumber.text}" );
                        Navigator.pushNamed(context, AppRoutes.introScreen);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to sign in: $e")),
                        );
                      }



                    }, onTimeout: (){});

              })),

          10.height(),
          Text.rich(
            TextSpan(
              text: 'By providing my phone number, I hereby agree and accept the ',
              style: context.titleSmall(), // your base text style
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: context.titleSmall()?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: context.titleSmall()?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' in use of the IRL app.',
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )



        ],),
      ),
    ),
    );
  }
}
