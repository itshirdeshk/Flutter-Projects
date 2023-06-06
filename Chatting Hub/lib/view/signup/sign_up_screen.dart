import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';

import '../../res/component/input_text_field.dart';
import '../../res/component/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameFocusNode = FocusNode();
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
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
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
                        "Enter your Email Address \nto register your account",
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
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                InputTextField(
                                  myController: userNameController,
                                  focusNode: userNameFocusNode,
                                  onFiledSubmittedValue: (value) {
                                    Utils.fieldFocus(context, userNameFocusNode,
                                        emailFocusNode);
                                  },
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? "Enter Username"
                                        : null;
                                  },
                                  keyBoardType: TextInputType.text,
                                  hint: "Username",
                                  obsecureText: false,
                                ),
                                InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFiledSubmittedValue: (value) {
                                    Utils.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
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
                                  onFiledSubmittedValue: (value) {
                                    Utils.fieldFocus(context, userNameFocusNode,
                                        emailFocusNode);
                                  },
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? "Enter Password"
                                        : null;
                                  },
                                  keyBoardType: TextInputType.text,
                                  hint: "Password",
                                  obsecureText: true,
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundButton(
                        loading: provider.loading,
                        title: "Sign Up",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.signup(
                                context,
                                userNameController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString());
                          }
                        },
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.loginView);
                        },
                        child: Text.rich(TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                  text: "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          fontSize: 15,
                                          decoration:
                                              TextDecoration.underline)),
                            ])),
                      )
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }
}
