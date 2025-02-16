import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/constants.dart';

class PostRepo {
  Future<http.Response> postRepository(api,
      {Map<String, dynamic>? body, bool tokenrequired = true}) async {
    const Duration timeoutDuration = Duration(seconds: 60);

    // Common headers
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': tokenrequired == true
          ? "Bearer ${UserSimplePreferences.getToken()}"
          : "",
    };

    try {
      final Uri uri = Uri.parse("${ApiClass.testUrl}$api");

      final http.Response response = await http
          .post(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(
            timeoutDuration,
            onTimeout: () =>
                http.Response('Error', 408), // Changed to 408 for timeout
          );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
