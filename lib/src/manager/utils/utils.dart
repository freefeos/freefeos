part of '../manager.dart';

final class AppUtils {
  const AppUtils();

  /// 在新页面中获取携带参数跳转传入的参数
  static dynamic getNavValue(BuildContext context, String kay) {
    final Object? obj = ModalRoute.of(context)?.settings.arguments;
    final Map? map = obj as Map?;
    return map?[kay];
  }

  /// 传入参数
  static Object? setNavValue(Map<String, dynamic> map) {
    return map as Object?;
  }

  /// 日志级别转颜色
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

  static Widget nonNullWidget({required Widget? child}) {
    return Container(child: child);
  }

  /// Widget转Widget列表
  static List<Widget> widget2WidgetList({required Widget? child}) {
    return <Widget>[nonNullWidget(child: child)];
  }

  /// NavigatorObserver转NavigatorObserver列表
  static List<NavigatorObserver> observer2ObserverList({
    required NavigatorObserver observer,
  }) {
    return <NavigatorObserver>[observer];
  }
}
