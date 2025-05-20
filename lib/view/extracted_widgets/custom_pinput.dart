import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  final String typeName;
  final TextEditingController pinController;
  final bool isShow;
  final bool isForgot;
  final bool isChangeTrans;
  final bool isCT;
  final void Function()? onTap;
  final Color? color;
  final Color? focusColor;
  final TextInputAction textAction;
  final bool autoClose;
  final int length;
  final double width;
  const CustomPinput({
    super.key,
    required this.pinController,
    this.isShow = false,
    this.isForgot = false,
    this.isChangeTrans = false,
    this.isCT = false,
    this.length = 4,
    this.onTap,
    this.typeName = 'Pin',
    this.color,
    this.focusColor,
    this.textAction = TextInputAction.done,
    this.autoClose = true,
    this.width = double.infinity,
  });

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Pinput(
          closeKeyboardWhenCompleted: widget.autoClose,
          autofocus: true,
          showCursor: false,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          animationCurve: Curves.bounceIn,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          controller: widget.pinController,
          length: widget.length,
          obscuringWidget: CircleAvatar(
            backgroundColor: theme.onSurface,
            radius: 5,
          ),
          textInputAction: widget.textAction,
          defaultPinTheme: PinTheme(
            width: double.infinity,
            // width: 12.8.w,
            height: 5.8.h,

            margin: const EdgeInsets.symmetric(horizontal: 6),
            textStyle: TextStyle(fontSize: 18.dp, color: theme.onSurface),
            decoration: BoxDecoration(
              color: theme.surface,
              //  boxShadow: [kBoxShadow],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: widget.color ?? theme.outlineVariant,
              ),
            ),
          ),
          obscureText: widget.isChangeTrans
              ? widget.isCT
              : widget.isShow
                  ? isVisible
                  : false,
          focusedPinTheme: PinTheme(
            width: double.infinity,
            height: 5.8.h,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            textStyle: TextStyle(
              fontSize: 18.dp,
              color: const Color.fromRGBO(30, 60, 87, 1),
            ),
            decoration: BoxDecoration(
              color: theme.surface,
              //boxShadow: [kBoxShadow],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: widget.focusColor ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        widget.isShow
            ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: widget.isForgot
                    ? Row(
                        children: [
                          Expanded(
                            flex: 11,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 10,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: CustomText(
                                text: isVisible ? '' : '',
                                color: Theme.of(context).primaryColor,
                                fontSize: 13.dp,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onTap ?? () {},
                            child: CustomText(
                              text: '',
                              decoration: TextDecoration.underline,
                              color: theme.onSurface,
                              fontSize: 13.dp,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: CustomText(
                              text: isVisible ? '' : '',
                              color: Theme.of(context).primaryColor,
                              fontSize: 13.dp,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ))
            : Container()
      ],
    );
  }
}
