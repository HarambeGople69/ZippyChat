import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/message_group_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/pages/chatting_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(15),
          vertical: ScreenUtil().setSp(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("id",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          UserModel userModel1 =
                              UserModel.fromMap(snapshot.data!.docs[0]);
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: userModel1.chatroomIds!.length,
                              itemBuilder: (context, indexx) {
                                // return Text(userModel.chatroomIds![index]);
                                //  List.from(userModel1
                                //     .chatroomIds!.reversed)[indexx]
                                return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("ChatRooms")
                                        .where("uid",
                                            isEqualTo: List.from(userModel1
                                                .chatroomIds!.reversed)[indexx])
                                        // isEqualTo:
                                        //     userModel1.chatroomIds![indexx])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasData) {
                                        MessageGroupModel messageGroupModel =
                                            MessageGroupModel.fromMap(
                                                snapshot.data!.docs[0]);
                                        // return Text(messageGroupModel.uid);
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setSp(10),
                                            vertical: ScreenUtil().setSp(10),
                                          ),
                                          child: Column(
                                            children: messageGroupModel.members
                                                .map(
                                                  (e) => e !=
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? StreamBuilder(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "Users")
                                                                  .where(
                                                                      "id",
                                                                      isEqualTo:
                                                                          e)
                                                                  .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot
                                                                .hasData) {
                                                              UserModel
                                                                  userModel =
                                                                  UserModel.fromMap(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[0]);
                                                              return InkWell(
                                                                onTap: () {
                                                                  // print(List.from(
                                                                  //     userModel1
                                                                  //         .chatroomIds!
                                                                  //         .reversed)[indexx]);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return ChattingPage(
                                                                      usermodel:
                                                                          userModel,
                                                                      messageGroupId: List.from(userModel1
                                                                          .chatroomIds!
                                                                          .reversed)[indexx],
                                                                      currentUserModel:
                                                                          userModel1,
                                                                    );
                                                                  }));
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        ScreenUtil()
                                                                            .setSp(30),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            userModel.image_url!,

                                                                        // Image.network(
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                Image.asset(
                                                                          "assets/images/profile.png",
                                                                        ),
                                                                        height:
                                                                            ScreenUtil().setSp(60),
                                                                        width: ScreenUtil()
                                                                            .setSp(60),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        //   )
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: ScreenUtil()
                                                                          .setSp(
                                                                              20),
                                                                    ),
                                                                    Text(userModel
                                                                        .user_name!),
                                                                  ],
                                                                ),
                                                              );
                                                            } else {
                                                              return Text(
                                                                  "Error occured");
                                                            }
                                                          })
                                                      : SizedBox(),
                                                )
                                                .toList(),
                                          ),
                                        );
                                      } else {
                                        return Text("Error occured");
                                      }
                                    });
                              });
                        });
                  } else {
                    return Text("Error occured");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
