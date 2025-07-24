import 'package:flu_kit/logger/good_log.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Logger {
  static late final Talker talker;

  // 初始化 Talker 配置
  static void configure() {
    talker = TalkerFlutter.init(
      settings: TalkerSettings(
        colors: {
          // TalkerLogType.verbose.key: AnsiPen()..yellow(),
          // TalkerLogType.info.key: AnsiPen()..gray(),
          // TalkerLogType.warning.key: AnsiPen()..yellow(),
          // TalkerLogType.error.key: AnsiPen()..red(),
          // TalkerLogType.critical.key: AnsiPen()..magenta,
          GoodLog.getKey: GoodLog.getPen,
        },
      ),
    );
  }

  static debug(String message) {
    talker.debug(message);
  }

  static info(String message) {
    talker.info(message);
  }

  static warning(String message) {
    talker.warning(message);
  }

  static error(String message) {
    talker.error(message);
  }

  static handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) {
    talker.handle(exception, stackTrace, msg);
  }

  // 添加带颜色的自定义日志方法
  static good(String message) {
    talker.logCustom(GoodLog(message));
  }

  static critical(String message) {
    talker.critical(message);
  }

  // 用于测试颜色输出
  static void testColors() {
    debug('🔍 这是 DEBUG 消息');
    info('ℹ️ 这是 INFO 消息');
    warning('⚠️ 这是 WARNING 消息');
    error('❌ 这是 ERROR 消息');
    good('✅ 这是 SUCCESS 消息');
    critical('🚨 这是 CRITICAL 消息');
    handle(Exception('test exception'));
  }
}
