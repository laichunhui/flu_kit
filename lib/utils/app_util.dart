import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class AppUtil {
  AppUtil._();

  /// 打开URL
  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// 打开电话
  static Future<bool> makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// 发送短信
  static Future<bool> sendSms(String phoneNumber, {String body = ''}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: body.isNotEmpty ? {'body': body} : null,
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// 发送电子邮件
  static Future<bool> sendEmail(
    String email, {
    String subject = '',
    String body = '',
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// 打开应用商店
  static Future<bool> openAppStore({String? appId}) async {
    if (Platform.isIOS) {
      final uri = Uri.parse('https://apps.apple.com/app/id${appId ?? ''}');
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
    } else if (Platform.isAndroid) {
      final uri = Uri.parse('market://details?id=${appId ?? ''}');
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
      // 如果无法打开应用商店，尝试打开Google Play网页版
      final webUri = Uri.parse(
        'https://play.google.com/store/apps/details?id=${appId ?? ''}',
      );
      if (await canLaunchUrl(webUri)) {
        return await launchUrl(webUri);
      }
    }
    return false;
  }

  /// 打开地图
  static Future<bool> openMap(
    double latitude,
    double longitude, {
    String label = '',
  }) async {
    if (Platform.isIOS) {
      final uri = Uri.parse(
        'https://maps.apple.com/?ll=$latitude,$longitude&q=${Uri.encodeComponent(label)}',
      );
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
    } else if (Platform.isAndroid) {
      final uri = Uri.parse(
        'geo:$latitude,$longitude?q=${Uri.encodeComponent(label)}',
      );
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
      // 如果无法打开地图应用，尝试打开Google地图网页版
      final webUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      );
      if (await canLaunchUrl(webUri)) {
        return await launchUrl(webUri);
      }
    }
    return false;
  }

  /// 分享文本
  static Future<bool> shareText(String text) async {
    // 注意：这个方法需要使用分享插件，如share_plus
    // 这里只是一个示例，实际实现可能需要额外的依赖
    return await openUrl(
      'https://api.whatsapp.com/send?text=${Uri.encodeComponent(text)}',
    );
  }

  /// 复制到剪贴板
  static void copyToClipboard(String text) {
    // 注意：这个方法需要使用剪贴板插件，如flutter/services.dart中的Clipboard
    // 这里只是一个示例，实际实现可能需要额外的导入
    // Clipboard.setData(ClipboardData(text: text));
  }

  /// 退出应用
  static void exitApp() {
    exit(0);
  }
}
