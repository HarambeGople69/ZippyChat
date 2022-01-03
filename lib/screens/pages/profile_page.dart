import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/authentication_page/cover.dart';
import 'package:myapp/services/app_shared_preferences/one_time_setup_shared_preference.dart';
import 'package:myapp/services/cloud_firebase_services/user_profile_detail.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class ProfilePage extends StatefulWidget {
  final String profileId;
  const ProfilePage({Key? key, required this.profileId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance!.addObserver(this);
  //   UserDetailFirestore().updateuserLoginStatus(true);
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     UserDetailFirestore().updateuserLoginStatus(true);
  //   } else {
  //     UserDetailFirestore().updateuserLoginStatus(false);
  //   }
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   UserDetailFirestore().updateuserLoginStatus(false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
        ),
      ),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(15),
              vertical: ScreenUtil().setSp(5),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("id", isEqualTo: widget.profileId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    UserModel userModel =
                        UserModel.fromMap(snapshot.data!.docs[0]);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OurSizedBox(),
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setSp(30),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: userModel.image_url!,

                                  // Image.network(
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/profile.png",
                                  ),
                                  height: ScreenUtil().setSp(150),
                                  width: ScreenUtil().setSp(150),
                                  fit: BoxFit.cover,
                                  //   )
                                ),
                              ),
                              userModel.id ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Positioned(
                                      bottom: -5,
                                      right: -5,
                                      child: InkWell(
                                        onTap: () {
                                          print(" Button Presssed");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              ScreenUtil().setSp(20),
                                            ),
                                          ),
                                          height: ScreenUtil().setSp(30),
                                          width: ScreenUtil().setSp(30),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        OurSizedBox(),
                        Row(
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setSp(10),
                            ),
                            Text(
                              userModel.user_name!,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                          ],
                        ),
                        OurSizedBox(),
                        Row(
                          children: [
                            Text(
                              "Bio: ",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setSp(10),
                            ),
                            Text(
                              userModel.bio!,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                          ],
                        ),
                        OurSizedBox(),
                        Row(
                          children: [
                            Text(
                              "Phone no: ",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setSp(10),
                            ),
                            Text(
                              userModel.phone_no!,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                            ),
                          ],
                        ),
                        OurSizedBox(),
                        userModel.id == FirebaseAuth.instance.currentUser!.uid
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Total connections: ",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                          ),
                                        ),
                                        OurSizedBox(),
                                        Text(
                                          userModel.connection_count.toString(),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        "Pending Request: ",
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(17.5),
                                        ),
                                      ),
                                      OurSizedBox(),
                                      Text(
                                        userModel.request_count.toString(),
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(17.5),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              )
                            : Container(),
                        OurSizedBox(),
                        OurElevatedButton(
                          title: userModel.id ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? "Save"
                              : "Back",
                          function: () {},
                        ),
                        OurSizedBox(),
                        userModel.id == FirebaseAuth.instance.currentUser!.uid
                            ? OurElevatedButton(
                                title: "Logout",
                                function: () async {
                                  print("Done Done");
                                  await UserDetailFirestore()
                                      .updateuserLoginStatus(false);
                                  await FirebaseAuth.instance.signOut();
                                  // ignore: prefer_const_constructors
                                  OneTimeSetUp().logout();
                                  Get.offAll(CoverPage());
                                },
                              )
                            : Container(),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }
}
