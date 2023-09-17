import 'package:chat_app/models/firebase_helper.dart';
import 'package:chat_app/pages/homepage.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

import 'models/user_model.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    UserModel? userModel = await FirebaseHelper.getUserById(currentUser.uid);

    if (userModel != null) {
      runApp(MainAppLoggedIn(
        userModel: userModel,
        firebaseUser: currentUser,
      ));
    }
  } else {
    runApp(const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}

class MainAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MainAppLoggedIn(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Homepage(
      userModel: userModel,
      firebaseUser: firebaseUser,
    ));
  }
}
