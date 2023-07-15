import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            text: "Sign Up",
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(CupertinoIcons.arrow_right),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const HeightSpacer(size: 50),
              ReusableText(
                  text: "Hello, Welcome!",
                  style: appstyle(30, Color(kDark.value), FontWeight.w600)),
              ReusableText(
                  text: "Fill the details for registeration",
                  style: appstyle(30, Color(kDarkGrey.value), FontWeight.w600)),
              const HeightSpacer(size: 50),
              CustomTextField(
                controller: name,
                keyboardType: TextInputType.text,
                hintText: "Name",
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Please enter your name";
                  } else {
                    return null;
                  }
                },
              ),
              const HeightSpacer(size: 20),
              CustomTextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                validator: (email) {
                  if (email!.isEmpty || !email.contains("@")) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              const HeightSpacer(size: 20),
              CustomTextField(
                controller: password,
                keyboardType: TextInputType.text,
                hintText: "Password",
                obscureText: signUpNotifier.obscureText,
                validator: (password) {
                  if (signUpNotifier.passwordValidator(password ?? '')) {
                    return "Please enter a valid password with at least one uppercase, lowercase, one digit, one special character and minimum length should be 8";
                  } else {
                    return null;
                  }
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    signUpNotifier.obscureText = !signUpNotifier.obscureText;
                  },
                  child: Icon(
                    signUpNotifier.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(kDark.value),
                  ),
                ),
              ),
              const HeightSpacer(size: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () => Get.to(() => const LoginPage()),
                    child: ReusableText(
                        text: "Login",
                        style:
                            appstyle(14, Color(kDark.value), FontWeight.w500))),
              ),
              const HeightSpacer(size: 50),
              CustomButton(
                text: "Sign Up",
                onTap: () {},
              )
            ],
          ),
        ),
      );
    });
  }
}
