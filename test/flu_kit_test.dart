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

  test('vita util', () {
    var input = "VITA";
    expect(VitaUtil.processPhrase(input), "VITA");
    input = "hi, VITA";
    expect(VitaUtil.processPhrase(input), "hi, VITA");
    input = "hey, VITA";
    expect(VitaUtil.processPhrase(input), "hey, VITA");
    input = "hello Vida";
    expect(VitaUtil.processPhrase(input), "hello VITA");
    input = "hola, Vita";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
    input = "hello";
    expect(VitaUtil.processPhrase(input), "hello");
    // input = "hello, weather";
    // expect(VitaUtil.processPhrase(input), "hello, VITA");
    input = "hola, mira";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
    input = "hola, waiter";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
    input = "hola, quetal";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
    input = "hola, how are you";
    expect(VitaUtil.processPhrase(input), "hola, how are you");
    input = "Ahora, mira";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
    input = "Ahora beta";
    expect(VitaUtil.processPhrase(input), "hola, VITA");
  });
}
