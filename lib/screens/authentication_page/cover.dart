import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/screens/authentication_page/login_page.dart';
import 'package:myapp/screens/authentication_page/sign_page.dart';
import 'package:myapp/services/app_shared_preferences/onboarding_shared_preference.dart';

class CoverPage extends StatefulWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  _CoverPageState createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  @override
  void initState() {
    super.initState();
    OnboardingPreference().done();
  }

  bool validEmail = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(20),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/login_icon.png",
                  height: ScreenUtil().setSp(300),
                  width: ScreenUtil().setSp(300),
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }));
                    },
                    child: const Text(
                      "Register",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                ],
              )
              // Center(
              //     child: TextFormField(
              //   controller: _email_controller,
              //   onChanged: (value) {
              //     if (value.contains("@gmail.com")) {
              //       print("Valid");
              //       setState(() {
              //         validEmail = true;
              //       });
              //     } else {
              //       print("Invalid");
              //       setState(() {
              //         validEmail = false;
              //       });
              //     }
              //   },
              //   decoration: InputDecoration(
              //       suffixIcon: validEmail == true ? Icon(Icons.check) : null),
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
