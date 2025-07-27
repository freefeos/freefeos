part of 'embedder.dart';

final class PlatformEmbedder extends Service implements FreeFEOSCompat {
  PlatformEmbedder();

  /// 日志标签
  static const String tag = 'embedder';

  late FreeFEOSCompat _linker;

  @override
  void onCreate() {
    super.onCreate();
    _linker = CompatLinker();
  }

  @override
  IBinder onBind(Want want) {
    return EmbedderBinder(embedder: this);
  }

  @override
  void addThemeModeChangeListener(VoidCallback callback) {
    return _invoke<void>(
      donut: (linker) => linker.addThemeModeChangeListener(callback),
      origin: () async {},
      error: (exception) async {
        Log.e(tag: tag, message: exception.toString());
      },
    );
  }

  @override
  AppBarTheme get getAppBarTheme {
    return _invoke<AppBarTheme>(
      donut: (linker) => linker.getAppBarTheme,
      origin: () =>
          AppBarTheme(centerTitle: false, toolbarHeight: kToolbarHeight),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return AppBarTheme();
      },
    );
  }

  @override
  String get getBaseSdkVersion {
    return _invoke<String>(
      donut: (linker) => linker.getBaseSdkVersion,
      origin: () => '0.0.0',
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return '';
      },
    );
  }

  @override
  String get getHostAppVersion {
    return _invoke<String>(
      donut: (linker) => linker.getHostAppVersion,
      origin: () => '0.0.0',
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return '';
      },
    );
  }

  @override
  NavigatorObserver get getNavigatorObserver {
    return _invoke<NavigatorObserver>(
      donut: (linker) => linker.getNavigatorObserver,
      origin: () => NavigatorObserver(),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return NavigatorObserver();
      },
    );
  }

  @override
  ThemeMode get getThemeMode {
    return _invoke<ThemeMode>(
      donut: (linker) => linker.getThemeMode,
      origin: () => ThemeMode.system,
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return ThemeMode.system;
      },
    );
  }

  @override
  Future<void> initDelegate() {
    return _invoke<Future<void>>(
      donut: (linker) => linker.initDelegate(),
      origin: () async {},
      error: (exception) async {
        Log.e(tag: tag, message: exception.toString());
      },
    );
  }

  @override
  Future<void> initDonutApi() {
    return _invoke<Future<void>>(
      donut: (linker) => linker.initDonutApi(),
      origin: () async {},
      error: (exception) async {
        Log.e(tag: tag, message: exception.toString());
      },
    );
  }

  @override
  Future<void> runDonutApp(Widget app) {
    return _invoke<Future<void>>(
      donut: (linker) => linker.runDonutApp(app),
      origin: () async => runApp(app),
      error: (exception) async {
        Log.e(tag: tag, message: exception.toString());
      },
    );
  }

  @override
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map query,
  }) {
    return _invoke<void>(
      donut: (linker) {
        return linker.setAppShareInfo(
          context: context,
          title: title,
          query: query,
        );
      },
      origin: () async {},
      error: (exception) async {
        Log.e(tag: tag, message: exception.toString());
      },
    );
  }

  @override
  void setClipboardData(String text, VoidCallback showTips) {
    return _invoke<void>(
      donut: (linker) => linker.setClipboardData(text, showTips),
      origin: () async {
        return Clipboard.setData(
          ClipboardData(text: text),
        ).then((_) => showTips());
      },
      error: (exception) async {
        Log.e(tag: '', message: exception.toString());
      },
    );
  }

  @override
  bool get checkEnv {
    return _invoke<bool>(
      donut: (linker) => linker.checkEnv,
      origin: () => false, // 非微信环境直接返回否
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return false;
      },
    );
  }

  @override
  Widget openEKit({required Widget child}) {
    return _invoke<Widget>(
      donut: (linker) => linker.openEKit(child: child),
      origin: () => Container(child: child),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return Container();
      },
    );
  }

  @override
  Widget openWeChat({required Widget child}) {
    return _invoke<Widget>(
      donut: (linker) => linker.openWeChat(child: child),
      origin: () => Container(child: child),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return Container();
      },
    );
  }

  @override
  Widget openSetting({required Widget child}) {
    return _invoke<Widget>(
      donut: (linker) => linker.openSetting(child: child),
      origin: () => Container(child: child),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return Container();
      },
    );
  }

  @override
  Widget openCustomer({required Widget child}) {
    return _invoke<Widget>(
      donut: (linker) => linker.openCustomer(child: child),
      origin: () => Container(child: child),
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return Container();
      },
    );
  }

  @override
  String get getAppId {
    return _invoke<String>(
      donut: (linker) => linker.getAppId,
      origin: () => 'com.freefeos.core',
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return '';
      },
    );
  }

  @override
  String get getVersionStage {
    return _invoke<String>(
      donut: (linker) => linker.getVersionStage,
      origin: () => '',
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return '';
      },
    );
  }

  @override
  String get getVersionName {
    return _invoke<String>(
      donut: (linker) => linker.getVersionName,
      origin: () => '0.0.0',
      error: (exception) {
        Log.e(tag: tag, message: exception.toString());
        return '';
      },
    );
  }

  /// 调用
  T _invoke<T>({
    required T Function(FreeFEOSCompat linker) donut,
    required T Function() origin,
    required T Function(dynamic exception) error,
  }) {
    try {
      if (_linker.checkEnv) {
        return donut(_linker);
      } else {
        return origin();
      }
    } catch (exception) {
      return error(exception);
    }
  }
}
