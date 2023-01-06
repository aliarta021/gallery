import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:revolution1401/common/utils/logging/log_helper.dart';

Future<DeviceInfo?> getDeviceData() async {
  String fcmToken = '';
  try {
    fcmToken = (await FirebaseMessaging.instance
            .getToken()
            .timeout(const Duration(seconds: 4))
            .catchError((e, s) => e.errLog())) ??
        '';
  } catch (e) {
    e.log();
  }
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    return DeviceInfo(
      deviceName: webBrowserInfo.browserName.toString(),
      deviceToken: fcmToken,
    );
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return DeviceInfo(
      systemVersion: androidDeviceInfo.version.release,
      apiLevel: androidDeviceInfo.version.sdkInt.toString(),
      deviceToken: fcmToken,
      deviceName: androidDeviceInfo.model,
    );
  } else if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return DeviceInfo(
        systemVersion: iosDeviceInfo.utsname.release,
        apiLevel: iosDeviceInfo.utsname.release,
        deviceToken: fcmToken,
        deviceName: iosDeviceInfo.model);
  }
  return null;
}

class DeviceInfo {
  DeviceInfo(
      {this.apiLevel,
      this.deviceName,
      this.deviceToken,
      this.systemVersion,
      this.deviceImei});

  String? deviceName;
  String? deviceToken;
  String? apiLevel;
  String? deviceImei;
  String? systemVersion;
}
