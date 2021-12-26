import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/screens/authentication_page/send_otp_screen.dart';
import 'package:myapp/screens/authentication_page/verify_otp_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());

  @override
  void dispose() {
    
    super.dispose();
    Get.find<LoginController>().toggle(false);
    Get.find<LoginController>().toggleAuthScreen(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: Get.find<LoginController>().processing.value,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(15),
                  vertical: ScreenUtil().setSp(5),
                ),
                child: Obx(
                  () => Get.find<LoginController>().authpage.value == true
                      ? const SendOTPScreen()
                      : const VerifyOTPScreen(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
