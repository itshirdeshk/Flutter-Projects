import 'dart:io';

import 'package:chat_app/models/ui_helper.dart';
import 'package:chat_app/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

class CompleteProfilePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfilePage({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  @override
  Widget build(BuildContext context) {
    File? imageFile;
    TextEditingController fullNameController = TextEditingController();

    void cropImage(XFile file) async {
      File? croppedFile = (await ImageCropper().cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 20)) as File?;

      if (croppedFile != null) {
        setState(() {
          imageFile = croppedFile;
        });
      }
    }

    void selectImage(ImageSource source) async {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        cropImage(pickedFile);
      }
    }

    void showPhotoOptions() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    leading: const Icon(Icons.photo_album),
                    title: const Text('Select from Gallery'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Select from Camera'),
                  )
                ],
              ),
            );
          });
    }

    void uploadData() async {
      UiHelper.showLoadingDialog(context, 'Uploading Image...');
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('Profilepictures')
          .child(widget.userModel.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();
      String fullName = fullNameController.text.trim();

      widget.userModel.profilePic = imageUrl;
      widget.userModel.fullname = fullName;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userModel.uid)
          .update(widget.userModel.toMap());

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Homepage(
            userModel: widget.userModel, firebaseUser: widget.firebaseUser);
      }));
    }

    void checkValues() {
      String fullName = fullNameController.text.trim();
      if (fullName == "" || imageFile == null) {
        UiHelper.showAlertDialog(
            context, 'Incomplete Details', 'Please fill all the details');
      } else {
        uploadData();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Complete Profile'),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    (imageFile != null) ? FileImage(imageFile!) : null,
                child: Icon(
                  (imageFile == null) ? Icons.person : null,
                  size: 60,
                ),
              ),
              onPressed: () {
                showPhotoOptions();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                checkValues();
              },
            )
          ],
        ),
      )),
    );
  }
}
