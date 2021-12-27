import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckReservedName{
  Future<bool> checkThisUserAlreadyPresentOrNot(
      String name) async {
    try {
      // AlertWidget().showLoading(context);

      QuerySnapshot findResult = await FirebaseFirestore.instance
          .collection("Users")
          .where("user_name", isEqualTo: name)
          .get();
      // ignore: unnecessary_null_comparison
      if (findResult.docs.isEmpty) {
        // Navigator.pop(context);
        // Navigator.pop(context);

        return true;
      } else {
        // Navigator.pop(context);
        // Navigator.pop(context);

        return false;
      }
    } on FirebaseException catch (e) {
      // Navigator.pop(context);

      return false;
    }
  }
}