part of '../standard.dart';

/// 系统能力调用ViewModel实现类
final class OSViewModel extends ContextWrapper
    with ViewModel
    implements IOSViewModel {
  /// 构造函数
  OSViewModel({
    required BuildContext context,
    required this.sdkInvoker,
    required this.detailsList,
    required this.child,
  });

  /// SDK调用器
  final SdkInvoker sdkInvoker;

  /// 模块列表
  final List<ModuleDetails> detailsList;

  final Widget? child;

  @override
  Widget? get getChild => child;

  /// 获取SDK调用器
  @override
  SdkInvoker get getSdkInvoker {
    return sdkInvoker;
  }

  @override
  void addThemeModeChangeListener(VoidCallback callback) {
    return fe.addThemeModeChangeListener(callback);
  }

  @override
  void setClipboardData(String text, VoidCallback showTips) {
    return fe.setClipboardData(text, showTips);
  }

  @override
  Widget openSetting({required Widget child}) {
    return fe.openSetting(child: child);
  }

  @override
  Widget openCustomer({required Widget child}) {
    return fe.openCustomer(child: child);
  }

  @override
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map query,
  }) {
    return fe.setAppShareInfo(context: context, title: title, query: query);
  }

  @override
  Widget openEKit({required Widget child}) {
    return fe.openEKit(child: child);
  }

  @override
  Widget openWeChat({required Widget child}) {
    return fe.openWeChat(child: child);
  }

  @override
  NavigatorObserver get getNavigatorObserver {
    return fe.getNavigatorObserver;
  }

  @override
  ThemeMode get getThemeMode {
    return fe.getThemeMode;
  }

  @override
  AppBarTheme get getAppBarTheme {
    return fe.getAppBarTheme;
  }

  @override
  bool get checkEnv {
    return fe.checkEnv;
  }

  @override
  String get getAppId {
    return fe.getAppId;
  }

  @override
  String get getVersionStage {
    return fe.getVersionStage;
  }

  @override
  String get getVersionName {
    return fe.getVersionName;
  }

  @override
  String get getHostAppVersion {
    return fe.getHostAppVersion;
  }

  @override
  String get getBaseSdkVersion {
    return fe.getBaseSdkVersion;
  }

  /// 获取模块列表
  @override
  List<ModuleDetails> get getDetailsList {
    return detailsList;
  }
}
