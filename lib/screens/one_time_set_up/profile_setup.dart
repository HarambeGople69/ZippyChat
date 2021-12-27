import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/services/check_reserved_name/check_reserved_name.dart';
import 'package:myapp/services/firebase_storage/user_profile_upload.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _bio_controller = TextEditingController();
  FocusNode _name_node = FocusNode();
  FocusNode _bio_node = FocusNode();
  File? file;
  final _formKey = GlobalKey<FormState>();
  pickImage() async {
    Permission _permission = Permission.storage;
    PermissionStatus _status = await _permission.request();

    if (!_status.isGranted) {
      await Permission.location.request();
    }
    if (_status.isPermanentlyDenied) {
      AppSettings.openAppSettings();
      print("=========================");
    }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        setState(() {});
        file = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("$e =========");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: Get.find<LoginController>().processing.value,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                    vertical: ScreenUtil().setSp(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Profile",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          letterSpacing: 1.2,
                        ),
                      ),
                      OurSizedBox(),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Center(
                          child: file != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(25),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.file(
                                      file!,
                                      height: ScreenUtil().setSp(150),
                                      width: ScreenUtil().setSp(
                                        150,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(25),
                                  ),
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    height: ScreenUtil().setSp(150),
                                    width: ScreenUtil().setSp(
                                      150,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      OurSizedBox(),
                      CustomTextField(
                        start: _name_node,
                        end: _bio_node,
                        controller: _name_controller,
                        validator: (value) {
                          if (value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Can't be empty";
                          }
                        },
                        title: "Enter name",
                        type: TextInputType.name,
                        number: 0,
                      ),
                      OurSizedBox(),
                      CustomTextField(
                        start: _bio_node,
                        controller: _bio_controller,
                        validator: (value) {
                          if (value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Can't be empty";
                          }
                        },
                        title: "Enter Bio",
                        type: TextInputType.name,
                        number: 1,
                      ),
                      OurSizedBox(),
                      OurElevatedButton(
                        title: "Proceed",
                        function: () async {
                          if (_formKey.currentState!.validate()) {
                            Get.find<LoginController>().toggle(true);
                            if (file == null) {
                              OurToast().showErrorToast(
                                  "Profile picture can't be empty");
                            } else {
                              final bool response = await CheckReservedName()
                                  .checkThisUserAlreadyPresentOrNot(
                                _name_controller.text.trim(),
                              );
                              if (response) {
                                UserProfileUpload().uploadProfile(
                                  _name_controller.text.trim(),
                                  _bio_controller.text.trim(),
                                  file,
                                );
                              } else {
                                OurToast()
                                    .showErrorToast("User name not available");
                                Get.find<LoginController>().toggle(false);
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
