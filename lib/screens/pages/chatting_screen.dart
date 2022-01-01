import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/message_group_model.dart';
import 'package:myapp/models/message_send_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/cloud_firebase_services/message_group.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_text_field.dart';

class ChattingPage extends StatefulWidget {
  final UserModel usermodel;
  final UserModel currentUserModel;
  final String messageGroupId;
  const ChattingPage(
      {Key? key,
      required this.usermodel,
      required this.messageGroupId,
      required this.currentUserModel})
      : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  TextEditingController _message_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _message_focus_node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(15),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.usermodel.image_url!,

                // Image.network(
                placeholder: (context, url) => Image.asset(
                  "assets/images/profile.png",
                ),
                height: ScreenUtil().setSp(40),
                width: ScreenUtil().setSp(40),
                fit: BoxFit.cover,
                //   )
              ),
            ),
            SizedBox(
              width: ScreenUtil().setSp(20),
            ),
            Text(
              widget.usermodel.user_name!,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(15),
            vertical: ScreenUtil().setSp(5),
          ),
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("ChatRooms")
                          .where("uid", isEqualTo: widget.messageGroupId)
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
                              MessageGroupModel.fromMap(snapshot.data!.docs[0]);
                          return messageGroupModel.messages.isNotEmpty
                              ? ListView.builder(
                                  itemCount: messageGroupModel.messages.length,
                                  itemBuilder: (context, index) {
                                    MessageSendModel messageSendModel =
                                        MessageSendModel.fromMap(
                                            messageGroupModel.messages[index]);
                                    return Column(
                                      // crossAxisAlignment:
                                      //     messageSendModel.senderId ==
                                      //             FirebaseAuth
                                      //                 .instance.currentUser!.uid
                                      //         ? CrossAxisAlignment.end
                                      //         : CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              messageSendModel.senderId ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                          children: [
                                            messageSendModel.senderId !=
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().setSp(15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: widget
                                                          .usermodel.image_url!,

                                                      // Image.network(
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        "assets/images/profile.png",
                                                      ),
                                                      height: ScreenUtil()
                                                          .setSp(40),
                                                      width: ScreenUtil()
                                                          .setSp(40),
                                                      fit: BoxFit.cover,
                                                      //   )
                                                    ),
                                                  )
                                                : Container(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: ScreenUtil().setSp(5),
                                                horizontal:
                                                    ScreenUtil().setSp(5),
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                vertical: ScreenUtil().setSp(5),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: ScreenUtil().setSp(30),
                                              decoration: BoxDecoration(
                                                  color: Colors.amberAccent,
                                                  borderRadius: messageSendModel
                                                              .senderId ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                        )
                                                      : BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                        )),
                                              child: Text(messageSendModel
                                                  .messageText!),
                                            ),
                                            messageSendModel.senderId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().setSp(15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: widget
                                                          .currentUserModel
                                                          .image_url!,

                                                      // Image.network(
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        "assets/images/profile.png",
                                                      ),
                                                      height: ScreenUtil()
                                                          .setSp(40),
                                                      width: ScreenUtil()
                                                          .setSp(40),
                                                      fit: BoxFit.cover,
                                                      //   )
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    );
                                  })
                              : Text("Has no data yet");
                        } else {
                          return Center(child: Text(("No data")));
                        }
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.image),
                  ),
                  Expanded(
                    child: CustomTextField(
                      start: _message_focus_node,
                      controller: _message_controller,
                      validator: (value) {},
                      title: "Send message",
                      type: TextInputType.name,
                      number: 1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_message_controller.text.trim().isEmpty) {
                        OurToast().showErrorToast("Message can't be empty");
                      } else {
                        MessageRoomsDetilFirestore().sendTextMessages(
                          
                          widget.messageGroupId,
                          FirebaseAuth.instance.currentUser!.uid,
                          _message_controller.text.trim(),
                          widget.currentUserModel,
                          widget.usermodel
                          
                        );
                        setState(() {
                          _message_controller.clear();
                        });
                        _message_focus_node.unfocus();
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
