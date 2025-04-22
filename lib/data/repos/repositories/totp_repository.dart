import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mdabali_report/data/models/totp_model.dart';
import 'package:mdabali_report/resources/constants.dart';

class TotpRepository {
  Future<TOtpModel> verifyOtp(String secret, String otp) async {
    try {
      var uri = Uri.parse("${ApiClass.testUrl}/gateway/otp/verify/totp");

      var request = http.MultipartRequest('POST', uri);
      request.fields['secret'] = secret;
      request.fields['otp'] = otp;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return TOtpModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to verify OTP");
      }
    } catch (e) {
      throw Exception("Otp error: ${e.toString()}");
    }
  }
}
