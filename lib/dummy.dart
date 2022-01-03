// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myapp/screens/authentication_page/cover.dart';
// import 'package:myapp/services/app_shared_preferences/one_time_setup_shared_preference.dart';

// class Dummy extends StatefulWidget {
//   const Dummy({Key? key}) : super(key: key);

//   @override
//   _DummyState createState() => _DummyState();
// }

// class _DummyState extends State<Dummy> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IconButton(
//         onPressed: () async {
//           await FirebaseAuth.instance.signOut();
//           OneTimeSetUp().logout();
//           // ignore: prefer_const_constructors
//           Get.offAll(CoverPage());
//         },
//         icon: Icon(
//           Icons.logout,
//         ),
//       ),
//     );
//   }
// }
