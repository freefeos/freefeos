part of '../common.dart';

///  Widget工具集
final class WidgetUtil {
  const WidgetUtil();

  /// Layout转Widget
  static Widget layout2Widget({required Layout layout}) {
    return LayoutFrame(layout: layout);
  }

  /// 非空WIdget
  static Widget nonNullWidget({required Widget? child}) {
    return Container(child: child);
  }
}
