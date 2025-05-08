import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/constants.dart';

import '../../view/extracted_widgets/custom_text.dart';

class GetRepo {
  // final CustomHttpInterceptor client;
  // http.BaseClient client;
  bool isLogout = false;
  GetRepo();
  Future<http.Response> getRepository(api, {bool tokenrequired = true}) async {
    var response = await http.get(
      Uri.parse("${ApiClass.testUrl}$api"),
      headers: {
        "Authorization": tokenrequired == true
            ? "Bearer ${UserSimplePreferences.getToken()}"
            : "",
        "Accept-Language":
            UserSimplePreferences.getLanguage() == true ? 'np' : 'en'
      },
    ).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 400); // Request Timeout response status code
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 440 || response.statusCode == 401) {
      //  isLogout = true;
      if (!isLogout) {
        isLogout = true;
        logout();
        throw Exception(response.reasonPhrase);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

void logout() {
  if (UserSimplePreferences.userLoggedIn() == true) {
    UserSimplePreferences.cleanToken();
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Session Expired'),
          content: Text('Session Expired, Please Login again'),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 9, 134, 255),
                  foregroundColor: Colors.white,
                  minimumSize: Size(100, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                child: CustomText(
                  text: 'ok',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  } else {
    print("ressetting");
    // _resetInactivityTimer();
  }
}
