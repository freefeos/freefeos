import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../framework/context.dart';

/// 平台工具集
final class PlatformUtil {
  const PlatformUtil();

  /// 无角标
  static bool get kNoBanner => !kDebugMode;

  /// 是否在浏览器中
  static bool get kIsWebBrowser => kIsWeb || kIsWasm;

  /// 是否有原生实现的平台潜入层
  static bool get kUseNative =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  /// 是否为桌面平台
  static bool get kIsDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS;
}

///  Widget工具集
final class WidgetUtil {
  const WidgetUtil();

  /// Widget转Widget列表
  static List<Widget> widget2WidgetList(Widget? child) {
    return <Container>[Container(child: child)];
  }

  /// Layout转Widget
  static Widget layout2Widget(Layout layout) {
    return LayoutFrame(layout: layout);
  }

  /// 是否为桌面端
  static bool kIsDesktopWithUI(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.linux ||
        Theme.of(context).platform == TargetPlatform.macOS;
  }
}
