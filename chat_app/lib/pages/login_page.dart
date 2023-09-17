import 'package:chat_app/models/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/homepage.dart';
import 'package:chat_app/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void logIn(String email, String password) async {
      UserCredential? credential;

      UiHelper.showLoadingDialog(context, 'Logging In...');

      try {
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        UiHelper.showAlertDialog(
            context, 'An Error Occured', e.message.toString());
        // if (kDebugMode) {
        //   print(e.code.toString());
        // }
      }

      if (credential != null) {
        String uid = credential.user!.uid;

        DocumentSnapshot userData =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        UserModel userModel =
            UserModel.fromMap(userData.data() as Map<String, dynamic>);

        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Homepage(
              userModel: userModel, firebaseUser: credential!.user!);
        }));
      }
    }

    void checkValues() {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email == "" || password == "") {
        UiHelper.showAlertDialog(
            context, 'Incomplete Details', 'Please fill all the details');
      } else {
        logIn(email, password);
      }
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Text(
                'Chat App',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', hintText: 'Enter your password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  checkValues();
                },
                color: Theme.of(context).colorScheme.secondary,
                child: const Text('Login'),
              )
            ]),
          ),
        ),
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 16),
          ),
          CupertinoButton(
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SignupPage();
              }));
            },
          )
        ],
      ),
    );
  }
}
