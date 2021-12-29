import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/pages/profile_page.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel =
                        UserModel.fromMap(snapshot.data!.docs[index]);
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(10),
                        vertical: ScreenUtil().setSp(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfilePage(profileId: userModel.id);
                          }));
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setSp(30),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: userModel.image_url,

                                // Image.network(
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/profile.png",
                                ),
                                height: ScreenUtil().setSp(60),
                                width: ScreenUtil().setSp(60),
                                fit: BoxFit.cover,
                                //   )
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setSp(20),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userModel.user_name,
                                ),
                                OurSizedBox(),
                                Text(
                                  userModel.bio,
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "data",
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "No Users",
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
