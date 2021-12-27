import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/dummy.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/services/app_shared_preferences/one_time_setup_shared_preference.dart';

class UserDetailFirestore {
  uploadDetail() async {
    var firestore = FirebaseFirestore.instance;
    final QuerySnapshot resultQuery = await firestore
        .collection("Users")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final List<DocumentSnapshot> documentSnapshots = resultQuery.docs;
    if (documentSnapshots.isEmpty) {
      print("=================== First Time =================");
      firestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          "id": FirebaseAuth.instance.currentUser!.uid,
          "phone_no": Get.find<LoginController>().phone_no.value,
          "user_name": "",
          "image_url": "",
        },
      );
      OneTimeSetUp().firstsetup();
      Get.offAll(
        const Dummy(),
      );
    } else {
      print("=============== Already done ================");
      OneTimeSetUp().secondsetup();
      Get.offAll(
        const DashBoardPage(),
      );
    }
  }
}
