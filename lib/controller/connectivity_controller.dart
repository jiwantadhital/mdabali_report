import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  var hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivityMonitoring();
  }

  void _initConnectivityMonitoring() {
    Connectivity().onConnectivityChanged.listen((results) {
      bool isConnected = !results.contains(ConnectivityResult.none);

      if (isConnected != hasInternet.value) {
        hasInternet.value = isConnected;

        if (!isConnected && Get.currentRoute != '/NoInternetPage') {
          Get.toNamed('/NoInternetPage');
        } else if (isConnected && Get.currentRoute == '/NoInternetPage') {
          Get.back();
        }
      }
    });
  }
}
