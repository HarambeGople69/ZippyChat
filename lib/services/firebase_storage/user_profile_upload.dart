import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/cloud_firebase_services/user_profile_detail.dart';
import 'package:myapp/services/compress_image/compress_image.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';

class UserProfileUpload {
  uploadProfile(String name, String bio, File? file) async {
    print("Inside uploadProfile");
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String downloadUrl = "";
    try {
      if (file != null) {
        File compressedFile = await compressImage(file);
        String filename = compressedFile.path.split('/').last;
        final uploadFile = await firebaseStorage
            .ref(
                "${FirebaseAuth.instance.currentUser!.uid}/profile_image/${filename}")
            .putFile(compressedFile);
        if (uploadFile.state == TaskState.success) {
          downloadUrl = await firebaseStorage
              .ref(
                  "${FirebaseAuth.instance.currentUser!.uid}/profile_image/${filename}")
              .getDownloadURL();
          await UserDetailFirestore().updateDetail(name, bio, downloadUrl);
        }
        print("Uploaded=======================");
      }
    } on FirebaseAuthException catch (e) {
      OurToast().showErrorToast(e.message!);
    }
  }
}
