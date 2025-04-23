import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/models/login_model.dart';
import 'package:mdabali_report/resources/constants.dart';

class LoginRepository {
  Future<LoginModel> login(String username, String password) async {
    try {
      var uri = Uri.parse("${ApiClass.testUrl}/gateway/web-login");

      var request = http.MultipartRequest('POST', uri);

      // Set fields
      request.fields['grant_type'] = 'password';
      request.fields['username'] = username;
      request.fields['password'] = password;

      request.headers.addAll({
        'Accept': 'application/json, text/plain, */*',
        'Origin': 'http://pg.infodev.com.np',
        'Referer': 'http://pg.infodev.com.np/',
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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
