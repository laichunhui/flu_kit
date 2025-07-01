import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// 获取主题
  ThemeData get theme => Theme.of(this);

  /// 获取文本主题
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 获取主题颜色
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 获取主色调
  Color get primaryColor => Theme.of(this).primaryColor;

  /// 获取次要色调
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  /// 获取屏幕尺寸
  Size get screenSize => MediaQuery.of(this).size;

  /// 获取屏幕宽度
  double get screenWidth => MediaQuery.of(this).size.width;

  /// 获取屏幕高度
  double get screenHeight => MediaQuery.of(this).size.height;

  /// 获取屏幕方向
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// 判断是否是横屏
  bool get isLandscape => orientation == Orientation.landscape;

  /// 判断是否是竖屏
  bool get isPortrait => orientation == Orientation.portrait;

  /// 获取状态栏高度
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// 获取底部安全区域高度
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// 获取设备像素比
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// 获取文本缩放比例
  double get textScaleFactor => MediaQuery.of(this).textScaler.scale(1.0);

  /// 判断是否是暗色主题
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 判断是否是亮色主题
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// 获取当前语言环境
  Locale get locale => Localizations.localeOf(this);

  /// 显示SnackBar
  void showSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
        action: action,
      ),
    );
  }

  /// 显示底部弹出框
  Future<T?> showBottomSheet<T>(
    Widget child, {
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => child,
    );
  }

  /// 显示对话框
  Future<T?> showAlertDialog<T>({
    required String title,
    required String content,
    String? cancelText,
    String confirmText = '确定',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: this,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onCancel?.call();
                  },
                  child: Text(cancelText),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                child: Text(confirmText),
              ),
            ],
          ),
    );
  }

  /// 显示加载对话框
  Future<T?> showLoadingDialog<T>({String message = '加载中...'}) {
    return showDialog<T>(
      context: this,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(message),
              ],
            ),
          ),
    );
  }

  /// 关闭对话框
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// 导航到指定页面
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// 替换当前页面
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  /// 清除所有页面并导航到指定页面
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// 获取Form
  FormState? get form => Form.of(this);

  /// 获取Scaffold
  ScaffoldState? get scaffold => Scaffold.of(this);

  /// 获取FocusScope
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// 隐藏键盘
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
