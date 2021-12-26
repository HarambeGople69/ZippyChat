import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/authentication_page/cover.dart';

class DummyHomePage extends StatefulWidget {
  const DummyHomePage({Key? key}) : super(key: key);

  @override
  _DummyHomePageState createState() => _DummyHomePageState();
}

class _DummyHomePageState extends State<DummyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          // ignore: prefer_const_constructors
          Get.offAll(CoverPage());
        },
        child: const Text("LogOut"),
      ),
    ));
  }
}
