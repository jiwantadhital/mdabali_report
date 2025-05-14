import 'package:get/get.dart';

class HttpErrorHandler {
  static void handleErrorResponse(int statusCode) {
    if (statusCode == 503 || statusCode == 502 ) {
      //unvailable function load gardini
      _showServiceUnavailablePage();
    }
  }

  static void _showServiceUnavailablePage() {
    Get.offNamed(
      '/service_error',
    );
  }
}
