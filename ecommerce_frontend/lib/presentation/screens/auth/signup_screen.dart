import 'package:ecommerce_frontend/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = 'signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce App'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: provider.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Create Account', style: TextStyles.heading2),
            const GapWidget(
              size: -10,
            ),
            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const GapWidget(
              size: 5,
            ),
            PrimaryTextField(
              controller: provider.emailController,
              labelText: "Email Address",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Email Address is required!";
                }
                if (!EmailValidator.validate(value.trim())) {
                  return "Invalid Email Address!";
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.passwordController,
              labelText: "Password",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Password is required!";
                }
                return null;
              },
              obsecureText: true,
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.cPasswordController,
              labelText: "Confirm Password",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Confirm your Password!";
                }

                if (value.trim() != provider.passwordController.text.trim()) {
                  return "Passwords do not match";
                }
                return null;
              },
              obsecureText: true,
            ),
            const GapWidget(),
            PrimaryButton(
              text: (provider.isLoading == true) ? "..." : "Create Account",
              onPressed: provider.createAccount,
            ),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(fontSize: 16)),
                const GapWidget(),
                LinkButton(
                  text: 'Log in',
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
