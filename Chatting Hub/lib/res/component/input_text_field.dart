import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {super.key,
      required this.myController,
      required this.focusNode,
      required this.onFiledSubmittedValue,
      required this.onValidator,
      required this.keyBoardType,
      required this.hint,
      this.enable = true,
      required this.obsecureText,
      this.autoFocus = false});

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obsecureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        cursorColor: AppColors.primaryTextTextColor,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        obscureText: obsecureText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(height: 0, fontSize: 20),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(20),
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                color: AppColors.primaryTextTextColor.withOpacity(0.8),
              ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldDefaultBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.alertColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryTextTextColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
