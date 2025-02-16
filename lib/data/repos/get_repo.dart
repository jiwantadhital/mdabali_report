import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/constants.dart';

class GetRepo {
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
    ;
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 440) {
      throw Exception(response.reasonPhrase);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
