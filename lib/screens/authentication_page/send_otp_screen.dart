import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/services/app_shared_preferences/authentication_services/phone_auth.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class SendOTPScreen extends StatefulWidget {
  const SendOTPScreen({Key? key}) : super(key: key);

  @override
  _SendOTPScreenState createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  // ignore: prefer_final_fields
  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OurSizedBox(),
          Text(
            "Enter your mobile number:",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(25),
              letterSpacing: 1.2,
            ),
          ),
          const OurSizedBox(),
          const OurSizedBox(),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(50),
              ),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: ScreenUtil().setSp(150),
                // color: Colors.pink,
                child: Lottie.asset(
                  "assets/animations/phone.json",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const OurSizedBox(),
          const OurSizedBox(),
          InternationalPhoneNumberInput(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Can't be empty";
              } else {
                return null;
              }
            },
            inputDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(10),
                vertical: ScreenUtil().setSp(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ScreenUtil().setSp(40),
                  ),
                ),
              ),
            ),
            selectorButtonOnErrorPadding: ScreenUtil().setSp(10),
            spaceBetweenSelectorAndTextField: ScreenUtil().setSp(5),
            textStyle: const TextStyle(
              color: Colors.amber,
            ),
            onInputChanged: (PhoneNumber number) {
              Get.find<LoginController>().setPhoneNo(number.phoneNumber!);
            },
            onInputValidated: (bool value) {
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.purple),
            // initialValue: ,

            textFieldController: _textEditingController,
            formatInput: false,
            keyboardType:
                const TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: const OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
            },
          ),

          SizedBox(
            height: ScreenUtil().setSp(60),
          ),
          // Spacer(),
          OurElevatedButton(
            title: "SEND OTP",
            function: () async {
              if (_formKey.currentState!.validate()) {
                Get.find<LoginController>().toggle(true);
                await PhoneAuth().sendOTP(context);
              }
            },
          ),
          SizedBox(
            height: ScreenUtil().setSp(60),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}
