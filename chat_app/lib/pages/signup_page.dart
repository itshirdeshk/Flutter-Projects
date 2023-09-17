import 'package:chat_app/models/ui_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/complete_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cPasswordController = TextEditingController();

    void checkValues() {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String cPassword = cPasswordController.text.trim();

      void signUp(String email, String password) async {
        UserCredential? credential;

        UiHelper.showLoadingDialog(context, 'Creating new account...');

        try {
          credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          UiHelper.showAlertDialog(
              context, 'An Error Occured', e.message.toString());
          if (kDebugMode) {
            print(e.code.toString());
          }
        }

        if (credential != null) {
          String uid = credential.user!.uid;

          UserModel newUser =
              UserModel(uid: uid, fullname: "", email: email, profilePic: "");

          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .set(newUser.toMap());

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return CompleteProfilePage(
                userModel: newUser, firebaseUser: credential!.user!);
          }));
        }
      }

      if (email == "" || password == "" || cPassword == "") {
        UiHelper.showAlertDialog(
            context, 'Incomplete Details', 'Please fill all the details');
      } else if (password != cPassword) {
        UiHelper.showAlertDialog(context, 'Password Mismatch',
            'The Passwords you entered do not match!');
      } else {
        signUp(email, password);
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
                height: 10,
              ),
              TextField(
                controller: cPasswordController,
                decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  checkValues();

                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const CompleteProfilePage();
                  // }));
                },
                color: Theme.of(context).colorScheme.secondary,
                child: const Text('Sign Up'),
              )
            ]),
          ),
        ),
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(fontSize: 16),
          ),
          CupertinoButton(
            child: const Text(
              'Log In',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
