import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  final ref = FirebaseDatabase.instance.ref('Users');
  FirebaseStorage storage = FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.camera_outlined,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.browse_gallery_outlined,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Gallery"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    Reference storageRef = FirebaseStorage.instance
        .ref('/profileImage ' + SessionController().userId.toString());
    UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      setLoading(false);
      Utils.toastMessage("Profile Updated...");
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Update Username")),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InputTextField(
                    myController: nameController,
                    focusNode: nameFocusNode,
                    onFiledSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.text,
                    hint: "Enter Username",
                    obsecureText: false)
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(SessionController().userId.toString()).update({
                      'userName': nameController.text.toString(),
                    }).then((value) {
                      nameController.clear();
                    });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }

  Future<void> showPhoneDialogAlert(BuildContext context, String phoneNumber) {
    phoneController.text = phoneNumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Phone Number")),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InputTextField(
                    myController: phoneController,
                    focusNode: phoneFocusNode,
                    onFiledSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.phone,
                    hint: "Enter Phone Number",
                    obsecureText: false)
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString(),
                    }).then((value) {
                      phoneController.clear();
                    });
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }
}
