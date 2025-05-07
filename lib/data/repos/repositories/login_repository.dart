import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/models/login_model.dart';
import 'package:mdabali_report/resources/constants.dart';
import 'package:mdabali_report/utils/get_device_detail.dart';

class LoginRepository {
  // final CustomHttpInterceptor client;
  LoginRepository();
  Future<LoginModel> login(String username, String password) async {
    try {
      var uri = Uri.parse("${ApiClass.testUrl}${ApiClass.loginUrl}");

      var request = http.MultipartRequest('POST', uri);
      String menuType = Platform.isAndroid ? 'ANDROID' : 'IOS';
      // Set fields
      request.fields['grant_type'] = 'password';
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['user_type'] = 'MOBILE';
      request.fields['menu_type'] = menuType;
      final deviceDetail = await getDeviceDetails();
      request.fields['deviceDetail'] = jsonEncode(deviceDetail);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("login request :${request.fields}");
      print('device details : $deviceDetail');
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LoginModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to login");
      }
    } catch (e) {
      throw Exception("Login error: ${e.toString()}");
    }
  }
}
