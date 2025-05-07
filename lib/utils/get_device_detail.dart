import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<Map<String, dynamic>> getDeviceDetails() async {
  final deviceInfo = DeviceInfoPlugin();
  final packageInfo = await PackageInfo.fromPlatform();

  String osVersion = '';
  String deviceModel = '';
  String androidApiLevel = '';
  String androidId = '';
  String mobileOs = Platform.isAndroid ? 'ANDROID' : 'IOS';

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    osVersion = androidInfo.version.release;
    deviceModel = androidInfo.model;
    androidApiLevel = androidInfo.version.sdkInt.toString();
    androidId = androidInfo.id;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    osVersion = iosInfo.systemVersion;
    deviceModel = iosInfo.utsname.machine;
    androidApiLevel = 'N/A';
    androidId = iosInfo.identifierForVendor ?? '';
  }

  // Get location
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  double lat = 0.0;
  double lng = 0.0;
  if (serviceEnabled && permission != LocationPermission.denied) {
    final position = await Geolocator.getCurrentPosition();
    lat = position.latitude;
    lng = position.longitude;
  }

  return {
    "OSVersion": osVersion,
    "appVersion": "${packageInfo.version}+${packageInfo.buildNumber}",
    "androidApiLevel": androidApiLevel,
    "device": deviceModel,
    "location": {"lat": lat, "lng": lng},
    "IMEI": androidId, // fallback to ID since IMEI is restricted
    "mobileOs": mobileOs
  };
}
