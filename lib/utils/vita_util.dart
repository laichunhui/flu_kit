class VitaUtil {
  /// 目标短语列表
  static const List<String> _targetPhrases = [
    'VITA',
    'hi, VITA',
    'hey, VITA',
    'hello VITA',
    'hola, VITA'
  ];

  /// 处理用户输入的短语，返回匹配的目标短语或原始输入
  static String processPhrase(String input) {
    if (input.trim().isEmpty) {
      return input;
    }

    final cleanInput = _cleanInput(input);

    // 查找最佳匹配
    String? bestMatch;
    double bestSimilarity = 0.0;

    for (String target in _targetPhrases) {
      final cleanTarget = _cleanInput(target);

      // 长度预检查 - 如果长度相差超过50%则跳过
      if (!_isLengthReasonable(cleanInput, cleanTarget)) {
        continue;
      }

      final similarity = _calculateSimilarity(cleanInput, cleanTarget);

      // 设置相似度阈值为0.5
      if (similarity > 0.5 && similarity > bestSimilarity) {
        bestSimilarity = similarity;
        bestMatch = target;
      }
    }

    return bestMatch ?? input;
  }

  /// 清理输入字符串（去除多余空格，转换为小写）
  static String _cleanInput(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// 检查长度是否在合理范围内
  static bool _isLengthReasonable(String input, String target) {
    final inputLen = input.length;
    final targetLen = target.length;

    if (inputLen == 0 || targetLen == 0) return false;

    // 长度相差不超过50%
    final ratio =
        inputLen > targetLen ? targetLen / inputLen : inputLen / targetLen;

    return ratio >= 0.5;
  }

  /// 计算两个字符串的相似度
  static double _calculateSimilarity(String input, String target) {
    // 先进行字符替换处理（处理读音相似的字符）
    final processedInput = _applyPhoneticTransforms(input);
    final processedTarget = _applyPhoneticTransforms(target);

    // 计算Levenshtein距离
    final distance = _levenshteinDistance(processedInput, processedTarget);
    final maxLen = processedInput.length > processedTarget.length
        ? processedInput.length
        : processedTarget.length;

    if (maxLen == 0) return 1.0;

    // 转换为相似度分数 (0-1)
    return 1.0 - (distance / maxLen);
  }

  /// 应用读音转换规则
  static String _applyPhoneticTransforms(String input) {
    String result = input;

    // 常见的读音混淆替换规则
    final Map<String, String> transforms = {
      'v': 'b', // vida -> bida (接近vita)
      'b': 'v', //
      'd': 't', // vida -> vita
      't': 'd', //
      'th': 'd', //
      'ph': 'f', //
      'ck': 'k', //
      'c': 'k', // 在某些情况下
      'z': 's', //
      's': 'z', //
      'j': 'y', // hey -> jey
      'y': 'j', //
      'i': 'e', // hi -> he
      'e': 'i', //
    };

    transforms.forEach((from, to) {
      result = result.replaceAll(from, to);
    });

    return result;
  }

  /// 计算Levenshtein编辑距离
  static int _levenshteinDistance(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    final List<List<int>> matrix =
        List.generate(s1.length + 1, (i) => List.filled(s2.length + 1, 0));

    // 初始化第一行和第一列
    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }

    // 计算编辑距离
    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;

        matrix[i][j] = [
          matrix[i - 1][j] + 1, // 删除
          matrix[i][j - 1] + 1, // 插入
          matrix[i - 1][j - 1] + cost, // 替换
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[s1.length][s2.length];
  }
}
