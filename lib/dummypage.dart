import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZIppyChat"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: prefer_const_constructors
              Get.offAll(CoverPage());
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Chats'),
            icon: Icon(Icons.chat_bubble_outline),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              title: Text('Calls'),
              icon: Icon(Icons.call_sharp),
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
              title: Text('Notifications'),
              icon: Icon(Icons.notifications),
              activeColor: Colors.pink),
          BottomNavyBarItem(
            title: Text('Search'),
            icon: Icon(Icons.search),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
