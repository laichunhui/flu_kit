extension StringExtension on String {
  /// 判断字符串是否为空或只包含空格
  bool get isBlank => trim().isEmpty;

  /// 判断字符串是否不为空且不只包含空格
  bool get isNotBlank => !isBlank;

  /// 如果字符串为空，则返回默认值
  String ifEmpty(String defaultValue) => isEmpty ? defaultValue : this;

  /// 如果字符串为空或只包含空格，则返回默认值
  String ifBlank(String defaultValue) => isBlank ? defaultValue : this;

  /// 将字符串首字母大写
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// 将字符串转换为驼峰命名
  String toCamelCase() {
    if (isEmpty) return this;
    return split(RegExp(r'[_\s-]'))
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join();
  }

  /// 将字符串转换为下划线命名
  String toSnakeCase() {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)?.toLowerCase()}',
    ).replaceAll(RegExp(r'^_'), '');
  }

  /// 检查字符串是否是有效的电子邮件格式
  bool get isEmail => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(this);

  /// 检查字符串是否是有效的URL格式
  bool get isUrl => RegExp(
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
  ).hasMatch(this);

  /// 检查字符串是否是有效的手机号码格式（中国大陆）
  bool get isPhoneNumber => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);

  /// 检查字符串是否只包含数字
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  /// 检查字符串是否是有效的身份证号码（中国大陆）
  bool get isIdCard => RegExp(r'^\d{17}[\dX]$').hasMatch(this);

  /// 将字符串截断到指定长度，并添加省略号
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// 移除字符串中的HTML标签
  String removeHtmlTags() {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// 获取字符串的MD5哈希值
  // String toMd5() {
  //   return md5.convert(utf8.encode(this)).toString();
  // }
}
