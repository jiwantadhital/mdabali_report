import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoService {
  static const MethodChannel _channel =
      MethodChannel('device_channel/android_id');

  static Future<String?> getAndroidId() async {
    try {
      final String? androidId = await _channel.invokeMethod('getAndroidId');
      return androidId;
    } on PlatformException {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getDeviceDetails() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String osVersion = '';
    String deviceModel = '';
    String androidApiLevel = '';
    String androidId = await getAndroidId() ?? 'UNKNOWN';
    String mobileOs = Platform.isAndroid ? 'ANDROID' : 'IOS';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      osVersion = androidInfo.version.release;
      deviceModel = androidInfo.model;
      androidApiLevel = androidInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.utsname.machine;
      androidApiLevel = 'N/A';
      androidId = iosInfo.identifierForVendor ?? 'UNKNOWN';
    }

    // Location
    double lat = 0.0;
    double lng = 0.0;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (serviceEnabled && permission != LocationPermission.denied) {
        final position = await Geolocator.getCurrentPosition();
        lat = position.latitude;
        lng = position.longitude;
      }
    } catch (e) {}

    return {
      'OSVersion': osVersion,
      'appVersion': '${packageInfo.version}+${packageInfo.buildNumber}',
      'androidApiLevel': androidApiLevel,
      'device': deviceModel,
      'location': {'lat': lat, 'lng': lng},
      'IMEI': androidId,
      'mobileOs': mobileOs
    };
  }
}
