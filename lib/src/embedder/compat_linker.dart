part of 'embedder.dart';

class CompatLinker implements FreeFEOSCompat {
  @override
  String get getAppName {
    return FreeFEOSCompat.instance.getAppName;
  }

  @override
  String get getPackageName {
    return FreeFEOSCompat.instance.getPackageName;
  }

  @override
  String get getVersionName {
    return FreeFEOSCompat.instance.getVersionName;
  }
  // @override
  // void addThemeModeChangeListener(VoidCallback callback) {
  //   return FreeFEOSCompat.instance.addThemeModeChangeListener(callback);
  // }

  // @override
  // void setAppShareInfo({
  //   required BuildContext context,
  //   required String title,
  //   required Map query,
  // }) {
  //   return FreeFEOSCompat.instance.setAppShareInfo(
  //     context: context,
  //     title: title,
  //     query: query,
  //   );
  // }

  // @override
  // AppBarTheme get getAppBarTheme {
  //   return FreeFEOSCompat.instance.getAppBarTheme;
  // }

  // @override
  // String get getBaseSdkVersion {
  //   return FreeFEOSCompat.instance.getBaseSdkVersion;
  // }

  // @override
  // String get getHostAppVersion {
  //   return FreeFEOSCompat.instance.getHostAppVersion;
  // }

  // @override
  // NavigatorObserver get getNavigatorObserver {
  //   return FreeFEOSCompat.instance.getNavigatorObserver;
  // }

  // @override
  // ThemeMode get getThemeMode {
  //   return FreeFEOSCompat.instance.getThemeMode;
  // }

  // @override
  // Future<void> initDelegate() {
  //   return FreeFEOSCompat.instance.initDelegate();
  // }

  // @override
  // Future<void> initDonutApi() {
  //   return FreeFEOSCompat.instance.initDonutApi();
  // }

  // @override
  // Future<void> runDonutApp(Widget app) {
  //   return FreeFEOSCompat.instance.runDonutApp(app);
  // }

  // @override
  // void setClipboardData(String text, VoidCallback showTips) {
  //   return FreeFEOSCompat.instance.setClipboardData(text, showTips);
  // }

  // @override
  // bool get checkEnv {
  //   return FreeFEOSCompat.instance.checkEnv;
  // }

  // @override
  // Widget openEKit({required Widget child}) {
  //   return FreeFEOSCompat.instance.openEKit(child: child);
  // }

  // @override
  // Widget openWeChat({required Widget child}) {
  //   return FreeFEOSCompat.instance.openWeChat(child: child);
  // }

  // @override
  // Widget openSetting({required Widget child}) {
  //   return FreeFEOSCompat.instance.openSetting(child: child);
  // }

  // @override
  // Widget openCustomer({required Widget child}) {
  //   return FreeFEOSCompat.instance.openCustomer(child: child);
  // }

  // @override
  // String get getAppId {
  //   return FreeFEOSCompat.instance.getAppId;
  // }

  // @override
  // String get getVersionStage {
  //   return FreeFEOSCompat.instance.getVersionStage;
  // }

  // @override
  // String get getVersionName {
  //   return FreeFEOSCompat.instance.getVersionName;
  // }
}
