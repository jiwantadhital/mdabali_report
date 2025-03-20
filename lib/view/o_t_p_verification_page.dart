import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/controller/o_t_p_controller.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_pinput.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final  Controller=Get.put(OTPController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48,),
            CustomText(text: 'New device detected!',
            fontSize: 16,
            color: Colors.deepOrange,),
            const SizedBox(height: 8,),
            CustomText(text: 'OTP Verification',
            fontSize: 24,
            weight: FontWeight.bold,
            family: 'SFPro',
            ),
            const SizedBox(height: 24,),
            CustomText(text:"We'll text you a code which lets us keep your account secure *****8845",
            fontSize: 20,
            textAlign: TextAlign.start,
            ),
          const SizedBox(height: 48,),
            Obx(()=> PinCodeTextField(
                appContext: context,
                length: 4,
                controller:Controller.otpController,
                onCompleted: (value){
                  Controller.verifyOtp(value);
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius:BorderRadius.circular(12),
                  fieldHeight: 55,
                  fieldWidth: 55,
                  activeFillColor: Colors.white,
                  //activeColor: Colors.grey[200]!,
                  inactiveFillColor: Colors.grey[200]!,
                ),
                keyboardType: TextInputType.number,
                enabled: !Controller.isCodeExpired.value,
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
            const SizedBox(height: 24,),
            Center(
              child: Obx(()=>CustomText(text: Controller.isCodeExpired.value?' ':'Resend code in ${Controller.remainingTime.value}secs',
              fontSize: 16,
              color: Colors.red,
              textAlign: TextAlign.center,
              weight: FontWeight.w500,)),
            ),
            const SizedBox(height: 72,),
            Obx(()=>LoginButton(
              color: Colors.blue,
              onPress: Controller.isCodeExpired.value?Controller.resendCode:null,
              text: 'Resend OTP',
            )),
            
        
        
          ],
        ),
      ),
    );
  }
}