part of '../standard.dart';

final class FreeFEOSSdk implements IFreeFEOSSdk {
  const FreeFEOSSdk(this.sdkInvoker);

  final SdkInvoker sdkInvoker;

  @override
  void addThemeModeChangeListener(VoidCallback callback) {
    return sdkInvoker<void>('addThemeModeChangeListener', {
      'callback': callback,
    });
  }

  @override
  void setClipboardData(String text, VoidCallback showTips) {
    return sdkInvoker<void>('setClipboardData', {
      'text': text,
      'showTips': showTips,
    });
  }

  @override
  Widget openSetting({required Widget child}) {
    final Widget? setting = sdkInvoker<Widget>('openSetting', {'child': child});
    return Container(child: setting);
  }

  @override
  Widget openCustomer({required Widget child}) {
    final Widget? customer = sdkInvoker<Widget>('openCustomer', {
      'child': child,
    });
    return Container(child: customer);
  }

  @override
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map<dynamic, dynamic> query,
  }) {
    return sdkInvoker<void>('setAppShareInfo', {
      'context': context,
      'title': title,
      'query': query,
    });
  }

  @override
  Widget openEKit({required Widget child}) {
    final Widget? ekit = sdkInvoker<Widget>('openEKit', {'child': child});
    return Container(child: ekit);
  }

  @override
  Widget openWeChat({required Widget child}) {
    final Widget? weChat = sdkInvoker<Widget>('openWeChat', {'child': child});
    return Container(child: weChat);
  }

  @override
  NavigatorObserver get getNavigatorObserver {
    return sdkInvoker<NavigatorObserver>('getNavigatorObserver') ??
        NavigatorObserver();
  }

  @override
  ThemeMode get getThemeMode {
    return sdkInvoker<ThemeMode>('getThemeMode') ?? ThemeMode.system;
  }

  @override
  AppBarTheme get getAppBarTheme {
    return sdkInvoker<AppBarTheme>('getAppBarTheme') ?? AppBarTheme();
  }

  @override
  bool get checkEnv {
    return sdkInvoker<bool>('checkEnv') ?? false;
  }

  @override
  String get getAppId {
    return sdkInvoker<String>('getAppId') ?? '';
  }

  @override
  String get getVersionStage {
    return sdkInvoker<String>('getVersionStage') ?? '';
  }

  @override
  String get getVersionName {
    return sdkInvoker<String>('getVersionName') ?? '';
  }

  @override
  String get getHostAppVersion {
    return sdkInvoker<String>('getHostAppVersion') ?? '';
  }

  @override
  String get getBaseSdkVersion {
    return sdkInvoker<String>('getBaseSdkVersion') ?? '';
  }
}
