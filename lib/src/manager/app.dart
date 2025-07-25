part of 'manager.dart';

final class App extends UiApp implements IAppOption {
  const App({super.key, required super.viewModel});

  /// 页面
  @override
  Map<RouteName, UiPageBuilder> get buildPages {
    return <RouteName, UiPageBuilder>{
      IndexPage.route: (_) => IndexPage(), // 首页
      ManagerPage.route: (_) => ManagerPage(), // 管理器
      AppsPage.route: (_) => AppsPage(), // 应用列表
    };
  }

  /// 样式
  @override
  ThemeData buildStyle(BuildContext context) {
    return ThemeData(
      useMaterial3: true, // Material3
      brightness: MediaQuery.platformBrightnessOf(context),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue, // 蓝色主题
        brightness: MediaQuery.platformBrightnessOf(context),
      ), // 主题颜色
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// 标题
  @override
  String buildTitle(BuildContext context) {
    return AppLocalizations.of(context).selfAppName;
  }

  /// ViewModel
  @override
  ViewModel get buildViewModel {
    return super.viewModel;
  }

  /// 构建应用
  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  /// 构造函数
  _AppState();

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return MaterialPageRoute<T>(builder: builder, settings: settings);
      },
      routes: widget.buildPages,
      builder: (context, child) => Banner(
        message: 'FREEFEOS',
        location: BannerLocation.topStart,
        child: Theme(
          data: widget.buildStyle(context),
          child: ScaffoldMessenger(
            child: MultiProvider(
              providers: [
                OSAbilityProvider(viewModel: widget.buildViewModel),
                ViewModelProvider<HomeViewModel>(
                  create: (_) => HomeViewModel(),
                ),
                ViewModelProvider<LogcatViewModel>(
                  create: (_) => LogcatViewModel(),
                ),
                ViewModelProvider<ModuleViewModel>(
                  create: (_) => ModuleViewModel(),
                ),
                ViewModelProvider<CalculatorViewModel>(
                  create: (_) => CalculatorViewModel(),
                ),
              ],
              child: child,
            ),
          ),
        ),
      ),
      onGenerateTitle: (context) => widget.buildTitle(context),
      color: Colors.transparent,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
