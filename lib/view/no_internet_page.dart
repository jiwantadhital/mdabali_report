import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/resources/images_constants.dart';
import 'package:mdabali_report/services/connectivity_service.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_snackbar.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/extracted_button.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImagesConstants.noInternet,height: 200,
              width: 200,),
              const SizedBox(height: 24,),
              CustomText(text: 'NO INTERNET CONNECTION',
              fontSize: 24,
              weight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16,),
              CustomText(text: 'Please check your internet connection',
              fontSize: 16,
              weight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: LoginButton(text: 'Refresh',
                color: Theme.of(context).colorScheme.primary,
                onPress: ()async{
                  final isConnected= await ConnectivityService.isConnected();
                  print('Refresh button: isConnected = $isConnected');
                  if(isConnected){
                             Get.back();
                  }
                  else{
                    CustomSnackbar(title: 'NO Internet Connection',
                     message: 'Still No Internet',
                    snackPosition: SnackPosition.TOP,
                     backgroundColor: Theme.of(context).colorScheme.surface,
                      textColor: Theme.of(context).colorScheme.onSurfaceVariant).show();
                  }
                },
                ),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}