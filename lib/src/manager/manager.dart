import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/model/model.dart';
import '../common/types/types.dart';
import '../common/sdk/option.dart';
import 'components/window_move_area.dart';
import 'intl/app_localizations.dart';
import 'pages/about.dart';
import 'pages/details.dart';
import 'pages/index.dart';
import 'pages/licenses.dart';
import 'pages/manager.dart';
import 'pages/plugin_ui.dart';
import 'pages/settings.dart';
import 'view_model/view_model.dart';

class ManagerApp extends StatelessWidget implements IAppOption {
  const ManagerApp({
    super.key,
    required this.contextAttacher,
    required this.pluginDetailsList,
    required this.pluginGetter,
    required this.pluginWidgetGetter,
    required this.runtimeChecker,
    required this.rootWidget,
  });

  /// 上下文附加器
  final ContextAttacher contextAttacher;

  /// 插件列表
  final List<PluginDetails> pluginDetailsList;

  /// 获取插件
  final PluginGetter pluginGetter;

  /// 获取插件界面
  final PluginWidgetGetter pluginWidgetGetter;

  /// 判断是否运行时
  final RuntimeChecker runtimeChecker;

  /// 应用根控件
  final Widget rootWidget;

  /// 页面
  @override
  Map<RouteName, WidgetBuilder> buildPages() {
    return <RouteName, WidgetBuilder>{
      IndexPage.route: (_) => IndexPage(),
      ManagerPage.route: (_) => ManagerPage(),
      PluginPage.route: (_) => PluginPage(),
      LicensesPage.route: (_) => LicensesPage(),
      AboutPage.route: (_) => AboutPage(),
      DetailsPage.route: (_) => DetailsPage(),
      SettingPage.route: (_) => SettingPage(),
    };
  }

  @override
  ThemeData buildStyle(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: MediaQuery.platformBrightnessOf(
        context,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: MediaQuery.platformBrightnessOf(
          context,
        ),
      ),
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

  @override
  String buildTitle(BuildContext context) {
    return AppLocalizations.of(context).packageName;
  }

  @override
  ViewModel buildViewModel(BuildContext context) {
    return ManagerViewModel(
      context: context,
      contextAttacher: contextAttacher,
      pluginDetailsList: pluginDetailsList,
      pluginGetter: pluginGetter,
      pluginWidgetGetter: pluginWidgetGetter,
      runtimeChecker: runtimeChecker,
      rootWidget: rootWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder: <T>(
        RouteSettings settings,
        WidgetBuilder builder,
      ) {
        return MaterialPageRoute<T>(
          builder: builder,
          settings: settings,
        );
      },
      routes: buildPages(),
      builder: (context, child) {
        return Theme(
          data: buildStyle(context),
          child: ScaffoldMessenger(
            child: ChangeNotifierProvider<ManagerViewModel>(
              create: (context) {
                final ViewModel viewModel = buildViewModel(context);
                assert(() {
                  if (viewModel is! ManagerViewModel) {
                    throw FlutterError(
                      'ViewModel 类型错误.',
                    );
                  }
                  return true;
                }());
                return viewModel as ManagerViewModel;
              },
              child: WindowMoveOverlay(
                child: child,
              ),
            ),
          ),
        );
      },
      onGenerateTitle: (context) => buildTitle(context), // 获取标题
      color: Colors.transparent, // 透明
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false, // 隐藏调试角标
    );
  }
}
