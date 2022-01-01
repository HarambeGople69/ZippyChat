import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/message_send_model.dart';
import 'package:myapp/models/user_model.dart';

class MessageRoomsDetilFirestore {
  var firestore = FirebaseFirestore.instance;

  makeRoom(String uid, UserModel user1, UserModel user2) async {
    await firestore.collection("ChatRooms").doc(uid).set({
      "uid": uid,
      "members": [
        user1.id,
        user2.id,
      ],
      "timestamp": Timestamp.now(),
      "messages": []
    });
  }

  sendTextMessages(String groupID, String senderId, String text,
      UserModel currentUser, UserModel receiverUser) async {
    MessageSendModel messageSendModel = MessageSendModel(
        senderId: senderId, type: text, messageText: text, imageUrl: "");
    await firestore.collection("ChatRooms").doc(groupID).update({
      "messages": FieldValue.arrayUnion(
        [messageSendModel.toMap()],
      )
    }).then((value) {
      MessageRoomsDetilFirestore()
          .controlIndex(groupID, currentUser, receiverUser);
    });
  }

  controlIndex(
      String groupId, UserModel currentUser, UserModel receiverUser) async {
    await firestore.collection("Users").doc(receiverUser.id).update({
      "chatroomIds": FieldValue.arrayRemove([groupId])
    }).then((value) async {
      await firestore.collection("Users").doc(receiverUser.id).update({
        "chatroomIds": FieldValue.arrayUnion([groupId])
      }).then((value) async {
        await firestore.collection("Users").doc(currentUser.id).update({
          "chatroomIds": FieldValue.arrayRemove([groupId])
        }).then((value) async {
          await firestore.collection("Users").doc(currentUser.id).update({
            "chatroomIds": FieldValue.arrayUnion([groupId])
          });
        });
      });
    });
  }
}
