import 'package:get/get.dart';

class HttpErrorHandler {
  static void handleErrorResponse(int statusCode) {
    if (statusCode == 503 || statusCode == 502 || statusCode == 500) {
      //unvailable function load gardini
      _showServiceUnavailablePage();
    }
  }

  static void _showServiceUnavailablePage() {
    Get.toNamed('/service_error');
  }
}
