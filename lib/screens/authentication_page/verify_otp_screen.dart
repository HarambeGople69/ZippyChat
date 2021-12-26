import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/services/app_shared_preferences/authentication_services/phone_auth.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? pin;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    PhoneAuth().vertfyPin(
      pin,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0454FF),
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(50),
              ),
            ),
            height: ScreenUtil().setSp(50),
            width: ScreenUtil().setSp(50),
            child: IconButton(
              onPressed: () {
                Get.find<LoginController>().toggleAuthScreen(true);
              },
              icon: Icon(
                Icons.arrow_back,
                size: ScreenUtil().setSp(
                  25,
                ),
              ),
            ),
          ),
          const OurSizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/otp_vector.png",
                height: ScreenUtil().setSp(80),
                width: ScreenUtil().setSp(80),
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: ScreenUtil().setSp(10),
              ),
              Text(
                "Enter code",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(25),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const OurSizedBox(),
          const OurSizedBox(),
          Text(
            "OTP has been sent to your mobile number\n${Get.find<LoginController>().phone_no.value}",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
            ),
          ),
          const OurSizedBox(),
          const OurSizedBox(),
          PinPut(
            eachFieldConstraints: BoxConstraints(
              maxHeight: ScreenUtil().setSp(40),
              maxWidth: ScreenUtil().setSp(40),
            ),
            textStyle: TextStyle(
              fontSize: ScreenUtil().setSp(15),
            ),
            separator: SizedBox(
              width: ScreenUtil().setSp(5),
            ),
            fieldsCount: 6,
            onChanged: (String pins) {
              setState(() {
                pin = pins;
              });
            },
            onSubmit: (String pin) {
              _showSnackBar(pin, context);
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
              if (value!.trim().isNotEmpty) {
                return null;
              } else {
                return "Please fill otp";
              }
            },
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration,
            selectedFieldDecoration: _pinPutDecoration,
            followingFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.deepPurpleAccent.withOpacity(.5),
              ),
            ),
          ),
          const OurSizedBox(),
          OurElevatedButton(
              title: "Continue",
              function: () {
                if (_formKey.currentState!.validate()) {
                  PhoneAuth().vertfyPin(pin!, context);
                }
              }),
        ],
      ),
    );
  }
}
