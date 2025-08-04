part of 'manager.dart';

final class App extends UiApp implements IAppOption {
  const App({super.key, required super.viewModel});

  /// 页面
  @override
  Map<RouteName, UiPageBuilder> get buildPages {
    return <RouteName, UiPageBuilder>{
      IndexPage.route: (_) => IndexPage(),
      ManagerPage.route: (_) => ManagerPage(),
      AppsPage.route: (_) => AppsPage(),
      AboutPage.route: (_) => AboutPage(),
      LicensesPage.route: (_) => LicensesPage(),
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
  List<ViewModelProvider> get buildViewModel {
    return [
      OSAbilityProvider(viewModel: viewModel),
      ViewModelProvider<IndexViewModule>(create: (_) => IndexViewModule()),
      ViewModelProvider<HomeViewModel>(create: (_) => HomeViewModel()),
      ViewModelProvider<LogcatViewModel>(create: (_) => LogcatViewModel()),
      ViewModelProvider<ModuleViewModel>(create: (_) => ModuleViewModel()),
      ViewModelProvider<CalculatorViewModel>(
        create: (_) => CalculatorViewModel(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      initialRoute: IndexPage.route,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return MaterialPageRoute<T>(builder: builder, settings: settings);
      },
      routes: buildPages,
      builder: (context, child) {
        return ScaffoldMessenger(
          child: RootTheme(
            data: Theme.of(context),
            child: Theme(
              data: buildStyle(context),
              child: MultiProvider(providers: buildViewModel, child: child),
            ),
          ),
        );
      },
      onGenerateTitle: (context) {
        return buildTitle(context);
      },
      color: Colors.transparent,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
