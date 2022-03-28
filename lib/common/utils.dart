import 'extensions.dart';

class Utils {
  ///
  static dynamic getCheckRange(
      num oldValue, num newValue, {num rangeStart = -1.0, num rangeEnd = 1}) {
    if (newValue.isBetween(rangeStart, rangeEnd)) {
      return newValue;
    }
    return oldValue;
  }
}

