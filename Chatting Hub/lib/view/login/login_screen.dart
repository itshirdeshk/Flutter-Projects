import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../res/component/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Welcome to APP",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your Email Address \nto connect to your account",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.06, bottom: height * 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            onFiledSubmittedValue: (value) {},
                            onValidator: (value) {
                              return value.isEmpty ? "Enter Email" : null;
                            },
                            keyBoardType: TextInputType.emailAddress,
                            hint: "Email",
                            obsecureText: false,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          InputTextField(
                            myController: passwordController,
                            focusNode: passwordFocusNode,
                            onFiledSubmittedValue: (value) {},
                            onValidator: (value) {
                              return value.isEmpty ? "Enter Password" : null;
                            },
                            keyBoardType: TextInputType.text,
                            hint: "Password",
                            obsecureText: true,
                          ),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: Text("Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 15,
                                decoration: TextDecoration.underline)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        loading: provider.loading,
                        title: "Login",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.login(context, emailController.text,
                                passwordController.text);
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpView);
                  },
                  child: Text.rich(
                      TextSpan(text: "Don't have an account?", children: [
                    TextSpan(
                        text: "Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 15,
                                decoration: TextDecoration.underline)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
