part of '../standard.dart';

/// SDK 接口
abstract interface class IfeOSdk {
  SdkInvoker get getSdkInvoker;
}

abstract interface class IFreeFEOSSdk {
  /// 添加主题模式监听
  void addThemeModeChangeListener(VoidCallback callback);
  void setClipboardData(String text, VoidCallback showTips);
  Widget openSetting({required Widget child});
  Widget openCustomer({required Widget child});
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map<dynamic, dynamic> query,
  });
  Widget openEKit({required Widget child});
  Widget openWeChat({required Widget child});

  /// 获取导航观察者
  NavigatorObserver get getNavigatorObserver;

  /// 获取主题模式
  ThemeMode get getThemeMode;

  /// 获取应用栏主题
  AppBarTheme get getAppBarTheme;

  /// 检查环境 true 为MPFlutter环境
  bool get checkEnv;

  /// 获取AppID
  String get getAppId;

  /// 获取小程序环境版本
  String get getVersionStage;

  /// 获取小程序版本号
  String get getVersionName;

  /// 获取宿主应用版本
  String get getHostAppVersion;

  /// 获取基础SDK版本
  String get getBaseSdkVersion;
}
