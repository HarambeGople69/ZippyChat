// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/screens/authentication_page/cover.dart';
import 'package:myapp/screens/outer_cover.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingPagesList = [
    PageModel(
      widget: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtil().setSp(350),
            // color: Colors.pink,
            child: Center(
              child: Lottie.asset(
                "assets/animations/onboarding_1.json",
                fit: BoxFit.contain,
              ),
            ),
          ),
          // OurSizedBox(),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                'Connecting Dots',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(25),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtil().setSp(350),
            // color: Colors.pink,
            child: Lottie.asset(
              "assets/animations/onboarding_2.json",
              fit: BoxFit.contain,
            ),
          ),
          // OurSizedBox(),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                'TITLE 2',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(25),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtil().setSp(350),
            // color: Colors.pink,
            child: Center(
              child: Lottie.asset(
                "assets/animations/onboarding_3.json",
                fit: BoxFit.contain,
              ),
            ),
          ),
          // OurSizedBox(),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                'TITLE 3',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(25),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        skipButtonStyle: SkipButtonStyle(
            skipButtonText: Text(
          "Skip",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.white,
          ),
        )),
        isSkippable: true,
        proceedButtonStyle: ProceedButtonStyle(
          proceedpButtonText: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              color: Colors.white,
            ),
          ),
          proceedButtonRoute: (context) {
            return Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const CoverPage();
            }));
          },
        ),
        pages: onboardingPagesList,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.line(
            lineDesign: LineDesign(
              lineType: DesignType.line_uniform,
            ),
          ),
        ),
      ),
    );
  }
}
