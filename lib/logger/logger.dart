import 'package:talker/talker.dart';
import 'dart:io';

class Logger {
  static late final Talker talker;

  // 初始化 Talker 配置
  static void init() {
    talker = Talker(
      settings: TalkerSettings(
        useConsoleLogs: true,
        // 强制启用颜色输出
        useHistory: true,
        maxHistoryItems: 100,
      ),
      logger: TalkerLogger(
        settings: TalkerLoggerSettings(
          // 强制启用颜色，即使在某些IDE中
          enableColors: true,
        ),
      ),
    );
  }

  // 如果未初始化，使用默认配置
  static Talker get _talker {
    try {
      return talker;
    } catch (e) {
      // 如果 talker 未初始化，创建一个默认的
      return Talker(
        settings: TalkerSettings(
          useConsoleLogs: true,
        ),
        logger: TalkerLogger(
          settings: TalkerLoggerSettings(
            enableColors: true,
          ),
        ),
      );
    }
  }

  static debug(String message) {
    _talker.debug(message);
  }

  static info(String message) {
    _talker.info(message);
  }

  static warning(String message) {
    _talker.warning(message);
  }

  static error(String message) {
    _talker.error(message);
  }

  static handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) {
    _talker.handle(exception, stackTrace, msg);
  }

  // 添加带颜色的自定义日志方法
  static success(String message) {
    _talker.log(message);
  }

  static critical(String message) {
    _talker.critical(message);
  }

  // 用于测试颜色输出
  static void testColors() {
    debug('🔍 这是 DEBUG 消息 - 灰色');
    info('ℹ️ 这是 INFO 消息 - 蓝色');
    warning('⚠️ 这是 WARNING 消息 - 黄色');
    error('❌ 这是 ERROR 消息 - 红色');
    success('✅ 这是 SUCCESS 消息 - 绿色');
    critical('🚨 这是 CRITICAL 消息 - 红色背景');
  }
}
