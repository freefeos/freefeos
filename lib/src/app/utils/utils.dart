import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final class AppUtils {
  /// 是否为桌面端
  static bool kIsDesktopWithUI(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.linux ||
        Theme.of(context).platform == TargetPlatform.macOS;
  }

  /// 无角标
  static bool get showBanner => !kDebugMode;
}

class LogUtils {
  const LogUtils();

  static Color level2Color(Level level, BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    if (level == Level.CONFIG) {
      return dark ? Colors.white38 : Colors.black38;
    } else if (level == Level.INFO) {
      return dark ? Colors.white : Colors.black;
    } else if (level == Level.WARNING) {
      return Colors.orange;
    } else if (level == Level.SEVERE) {
      return Colors.red;
    } else if (level == Level.SHOUT) {
      return Colors.pinkAccent;
    } else {
      return dark ? Colors.white : Colors.black;
    }
  }
}
