import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  DeviceUtil._();

  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static AndroidDeviceInfo? _androidInfo;
  static IosDeviceInfo? _iosInfo;
  static PackageInfo? _packageInfo;

  /// 初始化设备信息
  static Future<void> init() async {
    if (Platform.isAndroid) {
      _androidInfo = await _deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      _iosInfo = await _deviceInfo.iosInfo;
    }

    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// 获取设备ID
  static String getDeviceId() {
    if (Platform.isAndroid) {
      return _androidInfo?.id ?? '';
    } else if (Platform.isIOS) {
      return _iosInfo?.identifierForVendor ?? '';
    }
    return '';
  }

  /// 获取设备型号
  static String getDeviceModel() {
    if (Platform.isAndroid) {
      return _androidInfo?.model ?? '';
    } else if (Platform.isIOS) {
      return _iosInfo?.model ?? '';
    }
    return '';
  }

  /// 获取设备操作系统版本
  static String getOsVersion() {
    if (Platform.isAndroid) {
      return _androidInfo?.version.release ?? '';
    } else if (Platform.isIOS) {
      return _iosInfo?.systemVersion ?? '';
    }
    return '';
  }

  /// 获取应用名称
  static String getAppName() {
    return _packageInfo?.appName ?? '';
  }

  /// 获取应用包名
  static String getPackageName() {
    return _packageInfo?.packageName ?? '';
  }

  /// 获取应用版本
  static String getAppVersion() {
    return _packageInfo?.version ?? '';
  }

  /// 获取应用构建号
  static String getBuildNumber() {
    return _packageInfo?.buildNumber ?? '';
  }

  /// 是否是Android设备
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  /// 是否是iOS设备
  static bool isIOS() {
    return Platform.isIOS;
  }
}
