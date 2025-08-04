part of '../compat.dart';

/// Flutter平台兼容层
final class FlutterCompat extends FreeFEOSCompat {
  FlutterCompat();

  /// 兼容层的日志标签
  static const String _tag = 'FlutterCompat';

  /// 初始化微信接口
  /// 务必保留这段代码，否则第一次调用 wx 接口会提示异常。
  @override
  Future<void> initDonutApi() async {}

  @override
  Future<void> runDonutApp(Widget app) async {
    return runApp(app);
  }

  @override
  Future<void> initDelegate() async {}

  @override
  void addThemeModeChangeListener(VoidCallback callback) {}

  @override
  void setClipboardData(String text, VoidCallback showTips) {}

  @override
  Widget openSetting({required Widget child}) {
    return child;
  }

  @override
  Widget openCustomer({required Widget child}) {
    return child;
  }

  @override
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map<dynamic, dynamic> query,
  }) {}

  @override
  Widget openEKit({required Widget child}) {
    return child;
  }

  @override
  Widget openWeChat({required Widget child}) {
    return child;
  }

  @override
  NavigatorObserver get getNavigatorObserver => NavigatorObserver();

  @override
  ThemeMode get getThemeMode {
    return ThemeMode.system;
  }

  /// 根据胶囊按钮位置精确计算顶部应用栏高度及适配胶囊按钮的右侧填充
  ///
  /// 计算公式:
  /// 高度: 2 x ( 胶囊按钮上边缘到屏幕上边缘距离 - 状态栏高度 ) + 胶囊按钮高度 = 顶部应用栏高度
  /// 填充: 屏幕宽度 - 屏幕左边缘到胶囊按钮右边缘距离 + 胶囊按钮宽度 = 右侧填充宽度
  @override
  AppBarTheme get getAppBarTheme {
    return AppBarTheme();
  }

  @override
  bool get checkEnv => false;

  @override
  String get getAppId {
    return '';
  }

  @override
  String get getVersionStage {
    return '';
  }

  @override
  String get getVersionName {
    return '';
  }

  @override
  String get getHostAppVersion {
    return '';
  }

  @override
  String get getBaseSdkVersion {
    return '';
  }
}
