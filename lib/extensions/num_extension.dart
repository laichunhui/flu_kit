import 'dart:math' as math;

extension NumExtension on num {
  /// 将数值限制在指定范围内
  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// 判断数值是否在指定范围内
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }

  /// 将数值四舍五入到指定小数位数
  double roundToDecimalPlaces(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (this * factor).round() / factor;
  }

  /// 将数值向上取整到指定小数位数
  double ceilToDecimalPlaces(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (this * factor).ceil() / factor;
  }

  /// 将数值向下取整到指定小数位数
  double floorToDecimalPlaces(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (this * factor).floor() / factor;
  }

  /// 将数值转换为带千位分隔符的字符串
  String toThousandsSeparator() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  /// 将数值转换为带货币符号的字符串
  String toCurrency({String symbol = '¥', int decimalPlaces = 2}) {
    return '$symbol${roundToDecimalPlaces(decimalPlaces).toStringAsFixed(decimalPlaces)}';
  }

  /// 将数值转换为百分比字符串
  String toPercentage({int decimalPlaces = 2}) {
    return '${(this * 100).roundToDecimalPlaces(decimalPlaces).toStringAsFixed(decimalPlaces)}%';
  }

  /// 将数值转换为文件大小字符串
  String toFileSize() {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) {
      return '${(this / 1024).roundToDecimalPlaces(2)} KB';
    }
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).roundToDecimalPlaces(2)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).roundToDecimalPlaces(2)} GB';
  }

  /// 将数值转换为时间字符串（格式：HH:MM:SS）
  String toTimeString() {
    final hours = (this ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((this % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = ((this % 3600) % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// 将数值转换为时间字符串（格式：MM:SS）
  String toMinuteSecondString() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// 将数值转换为罗马数字
  String toRoman() {
    if (this <= 0 || this >= 4000) {
      throw ArgumentError('Number must be between 1 and 3999');
    }

    final values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    final symbols = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    var result = '';
    var num = toInt();

    for (var i = 0; i < values.length; i++) {
      while (num >= values[i]) {
        num -= values[i];
        result += symbols[i];
      }
    }

    return result;
  }

  /// 将数值转换为中文数字
  String toChineseNumber() {
    if (this < 0 || this > 9999999999999) {
      throw ArgumentError('Number must be between 0 and 9999999999999');
    }

    final chineseDigits = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九'];
    final chineseUnits = [
      '',
      '十',
      '百',
      '千',
      '万',
      '十',
      '百',
      '千',
      '亿',
      '十',
      '百',
      '千',
      '兆',
    ];

    if (this == 0) return chineseDigits[0];

    final digits = toString().split('').map(int.parse).toList();
    var result = '';
    var lastDigit = -1;

    for (var i = 0; i < digits.length; i++) {
      final digit = digits[i];
      final position = digits.length - i - 1;

      if (digit == 0) {
        if (lastDigit != 0) {
          result += chineseDigits[0];
        }
      } else {
        if (position == 1 && digit == 1 && result.isEmpty) {
          result += chineseUnits[position];
        } else {
          result += chineseDigits[digit] + chineseUnits[position];
        }
      }

      lastDigit = digit;
    }

    return result;
  }
}
