import 'package:flutter_test/flutter_test.dart';
import 'package:flu_kit/flu_kit.dart';

void main() {
  test('string util', () {
    var str = "1234567890ABC";
    expect(StringUtil.isBlank(str), false);
    expect(StringUtil.isNotBlank(str), true);
    expect(StringUtil.ifEmpty(str, ""), str);
    expect(StringUtil.ifBlank(str, ""), str);
    expect(StringUtil.capitalize(str), "1234567890ABC");
    expect(StringUtil.toCamelCase(str), "1234567890ABC");
    expect(StringUtil.toSnakeCase(str), "1234567890_a_b_c");
  });

  test('num extension', () {
    var num = 12345.6789;
    expect(num.toThousandsSeparator(), "12,345.6,789");
    expect(num.toCurrency(), "¥12345.68");
    expect(num.toPercentage(), "1234567.89%");
    expect(num.toFileSize(), "12.06 KB");
    var time = 12345;
    expect(time.toTimeString(), "03:25:45");
    expect(time.toMinuteSecondString(), "205:45");
  });
}
