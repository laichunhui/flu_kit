extension ListExtension<T> on List<T> {
  /// 获取列表中的第一个元素，如果列表为空则返回null
  T? get firstOrNull => isEmpty ? null : first;

  /// 获取列表中的最后一个元素，如果列表为空则返回null
  T? get lastOrNull => isEmpty ? null : last;

  /// 获取列表中指定索引的元素，如果索引越界则返回null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// 如果列表为空，则返回默认值
  List<T> ifEmpty(List<T> defaultValue) {
    return isEmpty ? defaultValue : this;
  }

  /// 返回列表中的前n个元素
  List<T> takeFirst(int n) {
    if (n <= 0) return [];
    if (n >= length) return List.from(this);
    return sublist(0, n);
  }

  /// 返回列表中的后n个元素
  List<T> takeLast(int n) {
    if (n <= 0) return [];
    if (n >= length) return List.from(this);
    return sublist(length - n);
  }

  /// 从列表中随机获取一个元素
  T? getRandom() {
    if (isEmpty) return null;
    return this[DateTime.now().millisecondsSinceEpoch % length];
  }

  /// 将列表分成指定大小的块
  List<List<T>> chunked(int size) {
    if (size <= 0) {
      throw ArgumentError('Size must be greater than 0');
    }

    final result = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      result.add(sublist(i, i + size > length ? length : i + size));
    }
    return result;
  }

  /// 将列表按指定条件分组
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final result = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      result.putIfAbsent(key, () => []).add(element);
    }
    return result;
  }

  /// 将列表转换为Map
  Map<K, V> associateBy<K, V>(
    K Function(T) keySelector,
    V Function(T) valueSelector,
  ) {
    final result = <K, V>{};
    for (final element in this) {
      result[keySelector(element)] = valueSelector(element);
    }
    return result;
  }

  /// 返回列表中满足条件的第一个元素，如果没有满足条件的元素则返回null
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// 返回列表中满足条件的最后一个元素，如果没有满足条件的元素则返回null
  T? lastWhereOrNull(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }

  /// 返回列表中满足条件的元素的个数
  int count(bool Function(T) test) {
    var count = 0;
    for (final element in this) {
      if (test(element)) count++;
    }
    return count;
  }

  /// 判断列表中是否所有元素都满足条件
  bool all(bool Function(T) test) {
    for (final element in this) {
      if (!test(element)) return false;
    }
    return true;
  }

  /// 判断列表中是否存在满足条件的元素
  bool any(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return true;
    }
    return false;
  }

  /// 判断列表中是否没有满足条件的元素
  bool none(bool Function(T) test) {
    return !any(test);
  }

  /// 移除列表中所有满足条件的元素
  List<T> removeWhere(bool Function(T) test) {
    return List.from(this)..removeWhere(test);
  }

  /// 移除列表中所有重复的元素
  List<T> distinct() {
    return toSet().toList();
  }

  /// 根据指定的键选择器移除列表中所有重复的元素
  List<T> distinctBy<K>(K Function(T) keySelector) {
    final result = <T>[];
    final keys = <K>{};

    for (final element in this) {
      final key = keySelector(element);
      if (keys.add(key)) {
        result.add(element);
      }
    }

    return result;
  }
}
