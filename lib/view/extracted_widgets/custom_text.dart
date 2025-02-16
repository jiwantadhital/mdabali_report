import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double hpadding;
  final double vpadding;
  final double height;
  double? fontSize = 12.dp;
  final FontWeight? weight;
  final Color? color;
  final String? family;
  final textAlign;
  final maxLine, decoration;
  final textOverflow;
  final double? letterSpacing;

  CustomText(
      {super.key,
      this.maxLine,
      this.height = 0,
      required this.text,
      this.fontSize,
      this.hpadding = 0,
      this.vpadding = 0,
      this.decoration = TextDecoration.none,
      this.weight = FontWeight.w400,
      this.color,
      this.family = 'SFpro',
      this.letterSpacing,
      this.textOverflow = TextOverflow.visible,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      maxLines: maxLine,
      style: TextStyle(
        height: height,
        decoration: decoration,
        letterSpacing: letterSpacing,
        fontFamily: 'SFpro',
        fontSize: fontSize,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontWeight: weight,
      ),
      textAlign: textAlign,
      overflow: textOverflow,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hpadding, vertical: vpadding),
        child: Text(
          text,
        ),
      ),
    );
  }
}
