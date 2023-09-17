import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChange;

  const PrimaryTextField(
      {super.key,
      required this.labelText,
      this.controller,
      this.obsecureText = false,
      this.initialValue,
      this.validator,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChange,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    );
  }
}
