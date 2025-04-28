import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:mdabali_report/bloc/totp_bloc/bloc/t_otp_bloc.dart';

import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/view/dash_board_page.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_snackbar.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends StatefulWidget {
  final String secret;
  const OTPVerificationPage({super.key, required this.secret});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  //final controller = Get.put(OTPController());

  final _pinController = TextEditingController();
  final _isButtonEnabled = ValueNotifier<bool>(false);
  final _remainingTime = ValueNotifier<int>(30);
  final _otpformKey = GlobalKey<FormState>();
  Timer? _timer;
  bool _isCodeExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _pinController.addListener(() {
      _isButtonEnabled.value = _pinController.text.length == 6;
    });
  }

  void _startTimer() {
    _remainingTime.value = 30;
    _isCodeExpired = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _isCodeExpired = true;
        _pinController.clear();
        _isButtonEnabled.value = false;
        // Automatically resend OTP
        // context.read<TOtpBloc>().add(
        //       VerifyOtpEvent(
        //         secret: widget.secret,
        //         otp: '',
        //       ),
        //     );
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _isButtonEnabled.dispose();
    _remainingTime.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _otpformKey,
          child: BlocConsumer<TOtpBloc, TOtpState>(
            listener: (context, state) async {
              if (state is TOtpSuccess) {
                _timer?.cancel();
                CustomSnackbar(
                        title: 'Success',
                        message: state.tOtpModel.message.toString(),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        textColor:
                            Theme.of(context).colorScheme.onSurfaceVariant)
                    .show();
                Get.off(() => DashBoardPage());
                final token = state.tOtpModel.data?.accessToken ?? "";
                await UserSimplePreferences.setToken(token);
              } else if (state is TOtpFailure) {
                _pinController.clear();
                _isButtonEnabled.value = false;
                CustomSnackbar(
                        title: 'Error',
                        message: state.error,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        textColor:
                            Theme.of(context).colorScheme.onSurfaceVariant)
                    .show();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  // CustomText(
                  //   text: 'New device detected!',
                  //   fontSize: 16,
                  //   color: colorScheme.inverseSurface,
                  // ),
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
                        "Please enter the verification code from your authenticator app (such as Google Authenticator) to access the account",
                    fontSize: 16,
                    textAlign: TextAlign.start,
                    color: colorScheme.onSurface,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: _pinController,
                    // onCompleted: (value) {
                    //   controller.verifyOtp(value);
                    // },
                    // onChanged: (value) {
                    //   setState(() {
                    //     _currentOtp=value;
                    //    // _isButtonEnsbled=value.length==6;
                    //   });
                    // },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      activeFillColor: colorScheme.onSurface,
                      //activeColor: Colors.grey[200]!,
                      inactiveFillColor: Colors.grey[200]!,
                    ),
                    keyboardType: TextInputType.number,
                    enabled: state is! TOtpLoading && !_isCodeExpired,
                    //!controller.isCodeExpired.value,
                    animationType: AnimationType.fade,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  ValueListenableBuilder<int>(
                    valueListenable: _remainingTime,
                    builder: (context, time, _) {
                      return CustomText(
                        text: _isCodeExpired
                            ? 'Code expired. Requesting a new one.'
                            : 'Your code expires in $time seconds',
                        fontSize: 16,
                        color: _isCodeExpired
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isButtonEnabled,
                    builder: (context, isEnabled, _) {
                      return LoginButton(
                        text: 'Verify OTP',
                        isLoading: state is TOtpLoading,
                        color: isEnabled && !_isCodeExpired
                            ? Colors.blue
                            : Colors.grey,
                        onPress: (state is TOtpLoading ||
                                !isEnabled ||
                                _isCodeExpired)
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_otpformKey.currentState!.validate()) {
                                  context.read<TOtpBloc>().add(
                                        VerifyOtpEvent(
                                          secret: widget.secret,
                                          otp: _pinController.text,
                                        ),
                                      );
                                  _pinController.clear();
                                  _isButtonEnabled.value = false;
                                }
                              },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
