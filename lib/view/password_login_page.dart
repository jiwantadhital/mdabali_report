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
//   final String username;
  const PasswordLoginPage({
    super.key,
    //required this.username
  });

  @override
  State<PasswordLoginPage> createState() => _PasswordLoginPageState();
}

class _PasswordLoginPageState extends State<PasswordLoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isEditable = false;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> mobileNotifier = ValueNotifier<String>('');
    bool isValid(String password) {
      return password.isNotEmpty;
    }

    var colorScheme = Theme.of(context).colorScheme;
    return AbsorbPointer(
      absorbing: _isEditable,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorScheme.surfaceContainer,
          body: SafeArea(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginLoading) {
                  //this is for absorb pointer
                  setState(() {
                    _isEditable = true;
                  });
                }
                if (state is LoginSuccess) {
                  final loginData = state.loginModel;
                  loginData.isOTPRequired == true
                      ? Get.off(() => OTPVerificationPage(
                            secret: loginData.data?.secret ?? '',
                          ))
                      : Get.off(() => DashBoardPage());
                  if (loginData.data!.accessToken != null) {
                    await UserSimplePreferences.setToken(
                        loginData.data!.accessToken ?? '');
                  }
                  //   final token = loginData.data?.accessToken ?? "";

                  print(loginData.data?.secret ?? 'jalfsdkn');
                }
                if (state is LoginFailure) {
                  //this is for absorb pointer
                  setState(() {
                    _isEditable = !_isEditable;
                  });
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
                                ImagesConstants.mdabaliLogo,
                                scale: 1,
                              )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Title section
                        CustomText(
                          text: 'Welcome To',
                          fontSize: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          text: 'Mdabali Report App',
                          fontSize: 24,
                          color: Colors.deepOrange,
                          weight: FontWeight.w500,
                        ),
                        //const SizedBox(height: 40),
                        //   UserPhoneNum(
                        //     username: widget.username,
                        //   ),
                        const SizedBox(height: 40),
                        CustomText(
                          text: 'Login or register',
                          fontSize: 20,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'User name',
                          controller: usernameController,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          keyboardType: TextInputType.name,
                          onchange: (value) {
                            mobileNotifier.value = value.toString();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
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
                            //   CustomText(
                            //     text: 'Forgot Password?',
                            //     fontSize: 16,
                            //     color: colorScheme.onSurfaceVariant,
                            //     decoration: TextDecoration.underline,
                            //   ),
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
                                          !isValid(passwordController.text) ||
                                          usernameController.text.isEmpty)
                                      ? null
                                      : () {
                                          FocusScope.of(context)
                                              .unfocus(); // Close keyboard
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            //this is for absorb pointer
                                            setState(() {
                                              _isEditable =
                                                  !_isEditable; // Toggle editable state
                                            });
                                            context.read<LoginBloc>().add(
                                                  LoginButtonPressed(
                                                    username: usernameController
                                                        .text
                                                        .trim(),
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
          )),
    );
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
