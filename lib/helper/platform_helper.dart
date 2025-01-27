import 'dart:io';

class PlatformHelper {
  static bool get isIos => Platform.isIOS;

  static bool isZeroOrNull(num? value) {
    return value == 0 || value == null;
  }

  static bool isEmptyOrNull(String? str) {
    return str == null || str.isEmpty;
  }
}
