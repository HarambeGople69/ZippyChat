import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/services/cloud_firebase_services/user_profile_detail.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';

class PhoneAuth {
  sendOTP(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: Get.find<LoginController>().phone_no.value,
        verificationCompleted: (PhoneAuthCredential credential) async {
          Get.find<LoginController>().toggle(true);
          try {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) {
            

              // Get.offAll(const DashBoardPage());
              OurToast().showSuccessToast("User authenticated successfully");
              Get.find<LoginController>().toggle(false);
              UserDetailFirestore().uploadDetail();
            });
          } on FirebaseAuthException catch (e) {
            Get.find<LoginController>().toggle(false);

            // print(e.message);
            // OurToast().showErrorToast(e.message!);
          }
          Get.find<LoginController>().toggle(false);
          Get.find<LoginController>().toggleAuthScreen(false);
        },
        verificationFailed: (FirebaseAuthException e) {
          OurToast().showErrorToast(e.message!);
          Get.find<LoginController>().toggle(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.find<LoginController>().setVerId(verificationId);
          Get.find<LoginController>().toggleAuthScreen(false);

          OurToast().showSuccessToast("OTP sent");
          Get.find<LoginController>().toggle(false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 110),
      );
    } on FirebaseAuthException catch (e) {
      OurToast().showErrorToast(e.message!);
    }
  }

  vertfyPin(String pin, BuildContext context) async {
    Get.find<LoginController>().toggle(true);

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: Get.find<LoginController>().verId.value,
      smsCode: pin,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        
        // Get.back();
        OurToast().showSuccessToast("User authenticated successfully");
        UserDetailFirestore().uploadDetail();
      });
      // Navigator.canPop(context);

      // OurToast().showSuccessToast("Login Successful");
      Get.find<LoginController>().toggle(false);
    } on FirebaseAuthException catch (e) {
      Get.find<LoginController>().toggle(false);

      // print(e.message);
      OurToast().showErrorToast(e.message!);
    }
  }
}
