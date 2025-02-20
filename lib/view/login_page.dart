import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/resources/images_constants.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_textfield.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';
import 'package:mdabali_report/view/password_login_page.dart';

import 'extracted_widgets/custom_text.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _numberController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: CustomText(
                        text: 'Logo',
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
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.language,
                                  size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              CustomText(
                                text: 'Eng',
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.question_mark,
                              size: 16, color: Colors.grey[600]),
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
                  color: Colors.grey,
                ),
                const SizedBox(height: 8),
                CustomText(
                  text: 'Mobile Banking',
                  fontSize: 24,
                  color: Colors.deepOrange,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 60),
                CustomText(
                  text: 'Login or register',
                  fontSize: 24,
                  weight: FontWeight.bold,
                ),
            
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Phone Number',
                  controller: _numberController,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  keyboardType: TextInputType.phone,
                  validator:(value){
                    if(value.isEmpty){
                      return 'Required Phone Number';
                    }
                    else if(value.length<10){
                      return 'Number should be of 10 digit';
                    }
                  }
                ),
            
                const SizedBox(height: 60),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Other Account Options',
                      fontSize: 16,
                      color: Colors.deepOrange,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 34),
            
                Center(
                  child: CustomText(
                    text: 'Not this cooperative?',
                    color: Colors.grey[600],
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Spacer(),
            
                LoginButton(
                  
                  onPress: (){
                    if(_formKey.currentState?.validate()?? false){
                    Get.to(PasswordLoginPage());}
                  },
                  color: Colors.blue[100],
                  text: 'Continue',
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
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 6,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.asset(
              ImagesConstants.info,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            child: Image.asset(ImagesConstants.info),
          ),
          Container(
            width: 40,
            height: 40,
            child: Image.asset(ImagesConstants.info),
          ),
        ],
      ),
    );
  }
}
