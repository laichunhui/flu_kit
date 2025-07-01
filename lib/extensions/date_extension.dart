import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// 格式化为字符串
  String format({String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(this);
  }

  /// 格式化为日期字符串
  String formatAsDate() {
    return format(pattern: 'yyyy-MM-dd');
  }

  /// 格式化为时间字符串
  String formatAsTime() {
    return format(pattern: 'HH:mm:ss');
  }

  /// 格式化为日期时间字符串
  String formatAsDateTime() {
    return format(pattern: 'yyyy-MM-dd HH:mm:ss');
  }

  /// 获取当天开始时间
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  /// 获取当天结束时间
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// 获取当月第一天
  DateTime startOfMonth() {
    return DateTime(year, month, 1);
  }

  /// 获取当月最后一天
  DateTime endOfMonth() {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// 获取当年第一天
  DateTime startOfYear() {
    return DateTime(year, 1, 1);
  }

  /// 获取当年最后一天
  DateTime endOfYear() {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }

  /// 添加年
  DateTime addYears(int years) {
    return DateTime(
      year + years,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// 添加月
  DateTime addMonths(int months) {
    final newMonth = month + months;
    final newYear = year + (newMonth - 1) ~/ 12;
    final normalizedMonth = ((newMonth - 1) % 12) + 1;

    var newDay = day;
    // 处理月份天数不同的情况
    final daysInMonth = DateTime(newYear, normalizedMonth + 1, 0).day;
    if (newDay > daysInMonth) {
      newDay = daysInMonth;
    }

    return DateTime(
      newYear,
      normalizedMonth,
      newDay,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// 添加天
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// 添加小时
  DateTime addHours(int hours) {
    return add(Duration(hours: hours));
  }

  /// 添加分钟
  DateTime addMinutes(int minutes) {
    return add(Duration(minutes: minutes));
  }

  /// 添加秒
  DateTime addSeconds(int seconds) {
    return add(Duration(seconds: seconds));
  }

  /// 是否是今天
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// 是否是昨天
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// 是否是明天
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// 是否是同一天
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// 是否是周末
  bool isWeekend() {
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }

  /// 是否是工作日
  bool isWeekday() {
    return !isWeekend();
  }

  /// 获取相对时间描述
  String getRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (isYesterday()) {
      return '昨天';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else {
      return '${(difference.inDays / 365).floor()}年前';
    }
  }
}
