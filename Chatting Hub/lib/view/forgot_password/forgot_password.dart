import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../res/component/round_button.dart';
import '../../view_model/forgot_password/forgot_password_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
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
                  "Enter your Email Address \nto recover your Password",
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
                        ],
                      ),
                    )),
                ChangeNotifierProvider(
                  create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        loading: provider.loading,
                        title: "Recover",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.forgotPassword(
                                context, emailController.text);
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
