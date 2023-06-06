import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/dashboard.dart';
import 'package:todo_app/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MainApp(
    token: prefs.getString('token'),
  ));
}

class MainApp extends StatelessWidget {
  final token;
  const MainApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JwtDecoder.isExpired(token) == false
          ? Dashboard(token: token,)
          : const SignInPage(),
    );
  }
}
