import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/resources/images_constants.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_textfield.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';
import 'package:mdabali_report/view/password_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ValueNotifier<String> mobileNotifier = ValueNotifier<String>('');

    bool isValid(String mobile) {
      return mobile.isNotEmpty;
    }

    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.surfaceContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                        child: Image.asset(
                      ImagesConstants.arjnaLogo,
                      scale: 1,
                      height: 40,
                      width: 40,
                    )),
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
                                  color: colorScheme.onSecondaryContainer),
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
                              size: 16, color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Title section
                const CustomText(
                  text: 'Secure and Convenient',
                  fontSize: 16,
                  color: Colors.grey,
                ),
                const SizedBox(height: 8),
                const CustomText(
                  text: 'Mobile Banking',
                  fontSize: 24,
                  color: Colors.deepOrange,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 60),
                const CustomText(
                  text: 'Login or register',
                  fontSize: 20,
                  weight: FontWeight.w400,
                ),

                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'User name',
                  controller: usernameController,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    mobileNotifier.value = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),

                const Spacer(),

                ValueListenableBuilder<String>(
                  valueListenable: mobileNotifier,
                  builder: (context, mobileNumber, child) {
                    final isvalid = isValid(usernameController.text);

                    return LoginButton(
                        onPress: isvalid
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Get.off(() => const PasswordLoginPage());
                                }
                              }
                            : null,
                        text: 'Continue',
                        textcolor: isvalid
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                        color: isvalid ? Colors.blue : Colors.transparent);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavAuth(size: size),
    );
  }
}

class BottomNavAuth extends StatelessWidget {
  const BottomNavAuth({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          kBoxShadow,
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              ImagesConstants.mdabaliLogo,
            ),
          ),
          //   SizedBox(
          //     width: 40,
          //     height: 40,
          //     child: Image.asset(ImagesConstants.arjnaLogo),
          //   ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(ImagesConstants.info),
          ),
        ],
      ),
    );
  }
}
