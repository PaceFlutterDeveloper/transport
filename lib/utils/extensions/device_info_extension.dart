import 'dart:io';

import 'package:device_info/device_info.dart';

extension DeviceInfoPluginExtensions on DeviceInfoPlugin {
  Future<String> getImeiNumber() async {
    String imei = "";

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await this.androidInfo;
        imei = androidInfo.androidId; // Access the Android ID as an alternative
      } else if (Platform.isIOS) {}
    } catch (e) {
      print('Failed to get IMEI number: $e');
    }

    return imei;
  }
}
