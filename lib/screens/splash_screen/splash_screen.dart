import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/screens/onboarding_screen/onboarding_screen.dart';
import 'package:myapp/screens/outer_cover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? done;

  @override
  void initState() {
    
    super.initState();
    getValidationData().whenComplete(() {
      Timer(
        const Duration(seconds: 2),
        done == null ? completed : loginPage,
      );
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedDone = sharedPreferences.getInt("done");

    setState(() {
      done = obtainedDone;
    });
  }

  void completed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ),
    );
  }

  void loginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OuterCoverPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.cover,
        height: ScreenUtil().setSp(250),
        width: ScreenUtil().setSp(250),
      )),
    );
  }
}
