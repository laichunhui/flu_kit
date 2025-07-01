class StringUtil {
  StringUtil._();

  /// 检查字符串是否为空或只包含空格
  static bool isBlank(String? str) {
    return str == null || str.trim().isEmpty;
  }

  /// 检查字符串是否不为空且不只包含空格
  static bool isNotBlank(String? str) {
    return !isBlank(str);
  }

  /// 如果字符串为空，则返回默认值
  static String ifEmpty(String? str, String defaultValue) {
    return (str == null || str.isEmpty) ? defaultValue : str;
  }

  /// 如果字符串为空或只包含空格，则返回默认值
  static String ifBlank(String? str, String defaultValue) {
    return isBlank(str) ? defaultValue : str!;
  }

  /// 将字符串首字母大写
  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  /// 将字符串转换为驼峰命名
  static String toCamelCase(String str) {
    if (str.isEmpty) return str;
    return str
        .split(RegExp(r'[_\s-]'))
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join();
  }

  /// 将字符串转换为下划线命名
  static String toSnakeCase(String str) {
    if (str.isEmpty) return str;
    return str
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)?.toLowerCase()}',
        )
        .replaceAll(RegExp(r'^_'), '');
  }

  /// 检查字符串是否是有效的电子邮件格式
  static bool isEmail(String str) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(str);
  }

  /// 检查字符串是否是有效的URL格式
  static bool isUrl(String str) {
    return RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    ).hasMatch(str);
  }

  /// 检查字符串是否是有效的手机号码格式（中国大陆）
  static bool isPhoneNumber(String str) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(str);
  }

  /// 检查字符串是否只包含数字
  static bool isNumeric(String str) {
    return RegExp(r'^\d+$').hasMatch(str);
  }

  /// 将字符串截断到指定长度，并添加省略号
  static String truncate(String str, int maxLength, {String ellipsis = '...'}) {
    if (str.length <= maxLength) return str;
    return '${str.substring(0, maxLength)}$ellipsis';
  }

  /// 移除字符串中的HTML标签
  static String removeHtmlTags(String str) {
    return str.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
