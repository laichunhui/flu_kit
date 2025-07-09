# flu_kit

一个功能丰富的Flutter实用工具包，提供字符串、日期、数字等类型的扩展方法以及常用的应用工具类，帮助您更高效地开发Flutter应用。

## 特性

### 扩展方法
- **字符串扩展** - 验证、格式化、转换等实用方法
- **数字扩展** - 数值处理和格式化
- **日期扩展** - 日期时间处理和格式化
- **颜色扩展** - 颜色操作和转换
- **上下文扩展** - 简化Flutter上下文操作
- **列表扩展** - 列表操作的便捷方法

### 工具类
- **应用工具** - URL打开、电话拨打、邮件发送等
- **设备工具** - 设备信息获取
- **文件工具** - 文件操作辅助
- **存储工具** - 本地存储操作
- **字符串工具** - 字符串处理工具

## 安装

在您的 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flu_kit: ^0.0.1
```

然后运行：

```bash
flutter pub get
```

## 使用方法

### 导入包

```dart
import 'package:flu_kit/flu_kit.dart';
```

### 字符串扩展示例

```dart
// 验证
String email = "test@example.com";
print(email.isEmail); // true

String phone = "13800138000";
print(phone.isPhoneNumber); // true

// 格式化
String text = "hello world";
print(text.capitalize()); // "Hello world"
print(text.toCamelCase()); // "HelloWorld"

// 工具方法
String longText = "这是一个很长的文本内容";
print(longText.truncate(5)); // "这是一个很..."

String html = "<p>Hello <b>World</b></p>";
print(html.removeHtmlTags()); // "Hello World"
```

### 应用工具示例

```dart
// 打开URL
await AppUtil.openUrl("https://flutter.dev");

// 拨打电话
await AppUtil.makePhoneCall("10086");

// 发送短信
await AppUtil.sendSms("10086", body: "Hello");

// 发送邮件
await AppUtil.sendEmail(
  "example@email.com",
  subject: "主题",
  body: "邮件内容"
);

// 打开地图
await AppUtil.openMap(39.9042, 116.4074, label: "北京");
```

## API文档

### 字符串扩展 (StringExtension)

| 方法/属性 | 说明 | 返回类型 |
|---------|------|---------|
| `isBlank` | 判断是否为空或只包含空格 | `bool` |
| `isNotBlank` | 判断是否不为空且不只包含空格 | `bool` |
| `ifEmpty(defaultValue)` | 为空时返回默认值 | `String` |
| `capitalize()` | 首字母大写 | `String` |
| `toCamelCase()` | 转换为驼峰命名 | `String` |
| `toSnakeCase()` | 转换为下划线命名 | `String` |
| `isEmail` | 验证邮箱格式 | `bool` |
| `isUrl` | 验证URL格式 | `bool` |
| `isPhoneNumber` | 验证手机号格式 | `bool` |
| `isNumeric` | 验证是否为数字 | `bool` |
| `isIdCard` | 验证身份证号格式 | `bool` |
| `truncate(maxLength)` | 截断字符串 | `String` |
| `removeHtmlTags()` | 移除HTML标签 | `String` |

### 应用工具 (AppUtil)

| 方法 | 说明 | 返回类型 |
|-----|------|---------|
| `openUrl(url)` | 打开URL | `Future<bool>` |
| `makePhoneCall(phoneNumber)` | 拨打电话 | `Future<bool>` |
| `sendSms(phoneNumber, body)` | 发送短信 | `Future<bool>` |
| `sendEmail(email, subject, body)` | 发送邮件 | `Future<bool>` |
| `openAppStore(appId)` | 打开应用商店 | `Future<bool>` |
| `openMap(lat, lng, label)` | 打开地图 | `Future<bool>` |
| `exitApp()` | 退出应用 | `void` |

## 贡献

欢迎提交问题和功能请求到 [GitHub Issues](https://github.com/laichunhui/flu_kit/issues)。

## 许可证

此项目基于 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新信息。
