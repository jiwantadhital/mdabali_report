import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';

class LoginButton extends StatelessWidget {
  final onPress, text, color, textcolor, isFull, isLoading, isNewButton, icon;
  final double? padBot;
  const LoginButton(
      {Key? key,
      this.onPress,
      this.text,
      this.color,
      this.icon = '',
      this.textcolor,
      this.isFull = true,
      this.isLoading = false,
      this.isNewButton = false,
      this.padBot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFull ? double.infinity : null,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: padBot == null
                ? Platform.isIOS
                    ? 16.0
                    : 8.0
                : padBot ?? 0),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPress,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: isLoading
                ? Theme.of(context).primaryColor.withOpacity(0.4)
                : Theme.of(context).disabledColor,
            elevation: 0,
            backgroundColor: color ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              side: isNewButton
                  ? BorderSide(color: Theme.of(context).primaryColor)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: isLoading
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: isFull ? 12.0 : 0.0),
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(0.5),
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: isFull ? 14.0 : 0.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon == ''
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.asset(
                                  icon,
                                  scale: 3,
                                ),
                              ),
                        CustomText(
                          text: text ?? "",
                          fontSize: 13.dp,
                          weight: FontWeight.w400,
                          color: textcolor ??
                              Theme.of(context).colorScheme.onPrimary,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
