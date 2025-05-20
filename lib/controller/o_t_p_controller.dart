import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/view/dash_board_page.dart';

class OTPController extends GetxController {
  var isCodeExpired = false.obs;
  var otp = ''.obs;
  var remainingTime = 30.obs;
  Timer? timer;
  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime.value--;
      } else {
        isCodeExpired.value = true;
        timer.cancel();
      }
    });
  }

  void resendCode() {
    remainingTime.value = 30;
    isCodeExpired.value = false;
    otp.value = '';
    otpController.clear();
    startTimer();
    Get.snackbar('Success', 'Sent OTP code');
    update();
  }

  void verifyOtp(String enteredOtp) {
    var correctOtp = '123456';
    if (isCodeExpired.value) {
      Get.snackbar('Error', 'OTP has expired. Please resend OTP');
    } else if (correctOtp == enteredOtp) {
      Get.snackbar('Success', 'OTP verified successfully');
      Get.off(() => const DashBoardPage());
    } else {
      Get.snackbar('Invalid', 'Invalid OTP code.Try again! ');
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    //otpController.dispose();
    super.onClose();
  }
}
