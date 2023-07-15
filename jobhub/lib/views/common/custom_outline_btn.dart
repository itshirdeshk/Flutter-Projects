// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn({
    Key? key,
    this.width,
    this.height,
    this.onTap,
    this.color2,
    required this.text,
    required this.color,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          border: Border.all(width: 1, color: color),
        ),
        child: Center(
            child: ReusableText(
                text: text, style: appstyle(16, color, FontWeight.w600))),
      ),
    );
  }
}
