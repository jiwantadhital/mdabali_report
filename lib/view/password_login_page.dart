import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/view/dash_board_page.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_snackbar.dart';
import 'package:mdabali_report/view/o_t_p_verification_page.dart';

import '../resources/images_constants.dart';
import 'extracted_widgets/custom_text.dart';
import 'extracted_widgets/custom_textfield.dart';
import 'extracted_widgets/extracted_button.dart';
import 'login_page.dart';

class PasswordLoginPage extends StatefulWidget {
  final String username;
  const PasswordLoginPage({super.key, required this.username});

  @override
  State<PasswordLoginPage> createState() => _PasswordLoginPageState();
}

class _PasswordLoginPageState extends State<PasswordLoginPage> {
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
    bool isValid(String password) {
      return password.isNotEmpty;
    }

    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme.surfaceContainer,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                final loginData = state.loginModel;
                loginData.isOTPRequired == true
                    ? Get.off(() => OTPVerificationPage())
                    : Get.off(() => DashBoardPage());
                final token = loginData.data?.accessToken ?? "";
                await UserSimplePreferences.setToken(token);
              }
              if (state is LoginFailure) {
                CustomSnackbar(
                        title: 'Error',
                        message: state.error,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: colorScheme.surface,
                        textColor: colorScheme.onSurfaceVariant)
                    .show();
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Image.asset(
                              ImagesConstants.arjnaLogo,
                              scale: 1,
                            )),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.language,
                                        size: 16,
                                        color:
                                            colorScheme.onSecondaryContainer),
                                    const SizedBox(width: 4),
                                    CustomText(
                                      text: 'Eng',
                                      color: colorScheme.onSurfaceVariant,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.question_mark,
                                    size: 16,
                                    color: colorScheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Title section
                      CustomText(
                        text: 'Secure and Convenient',
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Mobile Banking',
                        fontSize: 24,
                        color: Colors.deepOrange,
                        weight: FontWeight.w500,
                      ),
                      const SizedBox(height: 40),
                      UserPhoneNum(
                        username: widget.username,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          maxLength: 16,
                          onchange: (value) {
                            passwordNotifier.value = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required password';
                            }
                          },
                          isPass: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          keyboardType: TextInputType.text,
                          suffixIconEnabled: true),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: 'Forgot Password?',
                            fontSize: 16,
                            color: colorScheme.onSurfaceVariant,
                            decoration: TextDecoration.underline,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 16),

                      // Center(
                      //   child: CustomText(
                      //     text: 'Not you?',
                      //     color: Colors.grey[600],
                      //     decoration: TextDecoration.underline,
                      //   ),
                      // ),
                      const Spacer(),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return ValueListenableBuilder(
                            valueListenable: passwordNotifier,
                            builder: (context, password, __) {
                              return LoginButton(
                                onPress: (state is LoginLoading ||
                                        !isValid(passwordController.text))
                                    ? null
                                    : () {
                                        FocusScope.of(context)
                                            .unfocus(); // Close keyboard
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context.read<LoginBloc>().add(
                                                LoginButtonPressed(
                                                  username: widget.username,
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                        }
                                      },
                                color: isValid(passwordController.text)
                                    ? Colors.blue
                                    : Colors.transparent,
                                text: 'Login',
                                textcolor: isValid(passwordController.text)
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                                isLoading: state
                                    is LoginLoading, // Enable loading animation
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavAuth(
          size: MediaQuery.of(context).size,
        ));
  }
}

class UserPhoneNum extends StatefulWidget {
  final String username;
  const UserPhoneNum({
    super.key,
    required this.username,
  });

  @override
  State<UserPhoneNum> createState() => _UserPhoneNumState();
}

class _UserPhoneNumState extends State<UserPhoneNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey[600]!)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(Icons.person,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Arjan saving and credit cooperative',
                weight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(
                height: 4,
              ),
              CustomText(
                text: widget.username,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              )
            ],
          )
        ],
      ),
    );
  }
}
