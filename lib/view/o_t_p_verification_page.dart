import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/controller/o_t_p_controller.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final controller = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 48,
            ),
            CustomText(
              text: 'New device detected!',
              fontSize: 16,
              color: colorScheme.inverseSurface,
            ),
            const SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'OTP Verification',
              fontSize: 24,
              weight: FontWeight.bold,
              family: 'SFPro',
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomText(
              text:
                  "We'll text you a code which lets us keep your account secure.",
              fontSize: 20,
              textAlign: TextAlign.start,
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              height: 48,
            ),
            Obx(
              () => PinCodeTextField(
                appContext: context,
                length:4,
                controller: controller.otpController,
                onCompleted: (value) {
                  controller.verifyOtp(value);
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 55,
                  fieldWidth: 55,
                  activeFillColor: colorScheme.onSurface,
                  //activeColor: Colors.grey[200]!,
                  inactiveFillColor: Colors.grey[200]!,
                ),
                keyboardType: TextInputType.number,
                enabled: !controller.isCodeExpired.value,
                animationType: AnimationType.fade,
              ),
            ),
            // CustomPinput(

            // pinController: Controller.otpController,
            // onTap: (value){
            //   Controller.verifyOtp(value);
            //   },
            // length: 4,
            // ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Obx(() => CustomText(
                    text: controller.isCodeExpired.value
                        ? ' '
                        : 'Resend code in ${controller.remainingTime.value}secs',
                    fontSize: 16,
                    color: colorScheme.error,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w500,
                  )),
            ),
            const SizedBox(
              height: 72,
            ),
            Obx(() => LoginButton(
                  color: Colors.blue,
                  onPress: controller.isCodeExpired.value
                      ? controller.resendCode
                      : null,
                  text: 'Resend OTP',
                )),
          ],
        ),
      ),
    );
  }
}
