part of 'miniprogram.dart';

/// 操作系统Shell
final class App extends UiApp implements IAppOption {
  /// 构造函数
  const App({super.key, required super.viewModel});

  /// 页面
  @override
  Map<RouteName, UiPageBuilder> get buildPages {
    return <RouteName, UiPageBuilder>{
      IndexPage.route: (_) => IndexPage(), // 管理器
      AppsPage.route: (_) => AppsPage(), // 应用列表
      ExhibitPage.route: (_) => ExhibitPage(), // 单页模式展示页面
    };
  }

  /// 样式
  @override
  ThemeData buildStyle(Brightness brightness, AppBarTheme appBarTheme) {
    return ThemeData(
      useMaterial3: true, // Material3
      brightness: brightness, // 深浅色模式
      colorScheme: ColorScheme.fromSeed(
        seedColor: V.colors.freefeosBlue, // 蓝色主题
        brightness: brightness, // 深浅色模式
      ), // 主题颜色
      // platform: TargetPlatform.iOS, // 微信小程序为iOS平台样式
      appBarTheme: appBarTheme, // AppBar主题
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
    return MultiProvider(
      providers: [
        // 用于调用系统能力的ViewModel
        OSAbilityProvider(viewModel: widget.buildViewModel),
        // 主页ViewModel
        ViewModelProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        // 日志ViewModel
        ViewModelProvider<LogcatViewModel>(create: (_) => LogcatViewModel()),
        // 模块列表ViewModel
        ViewModelProvider<ModuleViewModel>(create: (_) => ModuleViewModel()),
        // 计算器ViewModel
        ViewModelProvider<CalculatorViewModel>(
          create: (_) => CalculatorViewModel(),
        ),
      ],
      // builder: (context, child) {
      //   return Consumer<OSAbility>(
      //     builder: (context, ability, child) {
      //       // 附加根构建上下文
      //       ability.attachRootBuildContext(context);
      //       // 返回原Widget
      //       return AppUtils.nonNullWidget(child: child);
      //     },
      //     child: child,
      //   );
      // },
      child: Shell(
        builder: (context, appBarTheme, themeMode, navigatorObserver) {
          return MaterialApp(
            routes: widget.buildPages,
            theme: widget.buildStyle(Brightness.light, appBarTheme),
            darkTheme: widget.buildStyle(Brightness.dark, appBarTheme),
            themeMode: themeMode,
            onGenerateTitle: (context) => widget.buildTitle(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorObservers: AppUtils.observer2ObserverList(
              observer: navigatorObserver,
            ),
          );
        },
      ),
    );
  }
}
