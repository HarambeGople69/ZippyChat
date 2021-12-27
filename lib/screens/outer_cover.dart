import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/screens/authentication_page/cover.dart';

class OuterCoverPage extends StatefulWidget {
  const OuterCoverPage({Key? key}) : super(key: key);

  @override
  _OuterCoverPageState createState() => _OuterCoverPageState();
}

class _OuterCoverPageState extends State<OuterCoverPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DashBoardPage();
        } else {
          return const CoverPage();
        }
      },
    );
  }
}
