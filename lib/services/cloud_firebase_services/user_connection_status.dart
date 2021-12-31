import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/models/user_model.dart';

class UserConnectionStatus {
  var firestore = FirebaseFirestore.instance;

  requestConnection(UserModel currentUser, UserModel destination) async {
    await firestore.collection("Users").doc(currentUser.id).update({
      "request": FieldValue.arrayUnion([destination.id]),
    });

    await firestore.collection("Users").doc(destination.id).update({
      "pending": FieldValue.arrayUnion([currentUser.id]),
      "request_count": destination.request_count! + 1,
    });
      // Get.find<NotificationController>()
      //         .setNotification(destination.request_count! + 1,);
  }

  cancelConnection(UserModel currentUser, UserModel destination) async {
    await firestore.collection("Users").doc(currentUser.id).update({
      "request": FieldValue.arrayRemove([destination.id]),
    });

    await firestore.collection("Users").doc(destination.id).update({
      "pending": FieldValue.arrayRemove([currentUser.id]),
      "request_count": destination.request_count! - 1,
    });
    // Get.find<NotificationController>()
    //           .setNotification(destination.request_count! - 1,);
  }

  approveConnection(UserModel requestsender, UserModel requestaccepter) async {
    await firestore.collection("Users").doc(requestsender.id).update({
      "request": FieldValue.arrayRemove([requestaccepter.id]),
      "connection": FieldValue.arrayUnion([requestaccepter.id]),
      "connection_count": requestsender.connection_count! + 1,
    });

    await firestore.collection("Users").doc(requestaccepter.id).update({
      "pending": FieldValue.arrayRemove([requestsender.id]),
      "connection": FieldValue.arrayUnion([requestsender.id]),
      "connection_count": requestaccepter.connection_count! + 1,
      "request_count": requestaccepter.request_count! - 1,
    });
    // Get.find<NotificationController>()
    //           .setNotification(destination.request_count! + 1,);
  }
}
