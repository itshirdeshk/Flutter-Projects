import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/forgot_password/forgot_password.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      auth
          .sendPasswordResetEmail(email: email)
          .then((value) {
        Navigator.pushNamed(context, RouteName.loginView);
        setLoading(false);
        Utils.toastMessage("Please Check your email to recover password");
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
