import 'package:flutter/material.dart';

import 'extracted_widgets/custom_text.dart';
import 'extracted_widgets/custom_textfield.dart';
import 'extracted_widgets/extracted_button.dart';

class PasswordLoginPage extends StatelessWidget {
  PasswordLoginPage({super.key});

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    child:  Center(
                      child: CustomText(
                        text: 'Logo',
                      )
                    ),
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
                            Icon(Icons.language, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            CustomText(text: 'Eng',
                            color: Colors.grey,)
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
                        child: Icon(Icons.question_mark, size: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Title section
              CustomText(
                text: 'Secure and Convenient',
                fontSize: 24,
                color: Colors.grey,
                ),
              const SizedBox(height: 8),
              CustomText(text:'Mobile Banking',
              fontSize: 32,
              color: Colors.deepOrange,
              weight: FontWeight.bold,),
              const SizedBox(height: 40),
              CustomText(text: 'Login or register',
              fontSize: 24,
              weight: FontWeight.bold,),

              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Password',
                 controller:_passwordController,
                 contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16),
                  keyboardType: TextInputType.phone,
                  suffixIconEnabled: [
                    Icon(Icons.remove_red_eye_rounded)
                  ],
                  ),

              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(text: 'Forgot Password?',
                  fontSize: 16,
                  color: Colors.deepOrange,
                  decoration: TextDecoration.underline,),
                  
                ],
              ),
              const SizedBox(height: 16),
              
              Center(
                child:CustomText(text: 'Not you?',
                color: Colors.grey[600],
                decoration: TextDecoration.underline,),
              ),
              const Spacer(),
              
              LoginButton(
                onPress: (){},
                color: Colors.blue[100],
                text: 'Login',
                textcolor: Colors.black,
                             
              ),
              const SizedBox(height: 20),
                   
             
            ],
          ),
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(items: [
                BottomNavigationBarItem(icon:Image.asset('lib/assets/info.png',
                scale: 4,),
                label:''),
                BottomNavigationBarItem(icon:Image.asset('lib/assets/info.png',
                scale: 1,),
                label:''),
                BottomNavigationBarItem(icon:Image.asset('lib/assets/info.png',
                scale: 1,),
                label:'')
              ])    ,
    );
  }
}