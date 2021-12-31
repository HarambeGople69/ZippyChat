import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/screens/one_time_set_up/profile_setup.dart';
import 'package:myapp/services/app_shared_preferences/one_time_setup_shared_preference.dart';

class UserDetailFirestore {
  var firestore = FirebaseFirestore.instance;
  uploadDetail() async {
    try {
      final QuerySnapshot resultQuery = await firestore
          .collection("Users")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      final List<DocumentSnapshot> documentSnapshots = resultQuery.docs;
      if (documentSnapshots.isEmpty) {
        print("=================== First Time =================");
        await firestore
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
          {
            "id": FirebaseAuth.instance.currentUser!.uid,
            "phone_no": Get.find<LoginController>().phone_no.value,
            "user_name": "",
            "image_url": "",
            "bio": "",
            "connection_count": 0,
            "request_count": 0,
            "connection": [],
            "request": [],
            "pending": [],
            "searchfrom": [],
            "created_at": Timestamp.now(),
          },
        );
        // Get.find<NotificationController>().setNotification(0);
        OneTimeSetUp().firstsetup();
        Get.offAll(
          const ProfileSetup(),
        );
        Get.find<LoginController>().toggle(false);
      } else {
        print("=============== Already done ================");
        OneTimeSetUp().secondsetup();
        Get.offAll(
          const DashBoardPage(),
        );
        Get.find<LoginController>().toggle(false);
      }
    } catch (e) {
      print(e);
    }
  }

  updateDetail(String name, String bio, String imageUrl) async {
    List<String> searchList = [];
    for (int i = 0; i <= name.length; i++) {
      searchList.add(
        name.substring(0, i).toLowerCase(),
      );
    }
    try {
      await firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "user_name": name,
        "image_url": imageUrl,
        "bio": bio,
        "searchfrom": searchList,
      }).then((value) {
        print("+++++DONE+++++");
        firestore
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .map((event) {
          UserModel userModel = UserModel.fromMap(event);
          // Get.find<NotificationController>()
          //     .setNotification(userModel.request_count!);
        });
        Get.find<LoginController>().toggle(false);
        OneTimeSetUp().secondsetup();
        Get.off(DashBoardPage());
      });
    } catch (e) {
      print(e);
    }
  }
}
