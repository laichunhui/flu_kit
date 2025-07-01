import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  StorageUtil._();

  static late SharedPreferences _prefs;

  /// 初始化SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 保存字符串
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// 获取字符串
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  /// 保存布尔值
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// 获取布尔值
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  /// 保存整数
  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// 获取整数
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  /// 保存双精度浮点数
  static Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// 获取双精度浮点数
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  /// 保存字符串列表
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// 获取字符串列表
  static List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  /// 保存对象（将对象转换为JSON字符串）
  static Future<bool> setObject(String key, Object value) async {
    final jsonString = jsonEncode(value);
    return await setString(key, jsonString);
  }

  /// 获取对象（将JSON字符串转换为对象）
  static T? getObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final jsonString = getString(key);
    if (jsonString.isEmpty) return null;

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  /// 保存对象列表（将对象列表转换为JSON字符串）
  static Future<bool> setObjectList<T>(String key, List<T> value) async {
    final jsonString = jsonEncode(value);
    return await setString(key, jsonString);
  }

  /// 获取对象列表（将JSON字符串转换为对象列表）
  static List<T> getObjectList<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    List<T> defaultValue = const [],
  }) {
    final jsonString = getString(key);
    if (jsonString.isEmpty) return defaultValue;

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return defaultValue;
    }
  }

  /// 检查是否包含指定的键
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// 获取所有键
  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// 删除指定的键
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// 清除所有数据
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
