import 'package:flutter/material.dart';

import '../sdk/option.dart';
import 'components/window_move_area.dart';
import 'intl/app_localizations.dart';
import 'pages/index.dart';
import 'pages/manager.dart';
import 'pages/plugin_ui.dart';

const String routeIndex = '/';
const String routeManager = '/manager';
const String routePlugin = '/manager/plugin';

class App implements IAppOption {
  /// 页面
  @override
  Map<String, WidgetBuilder> pages() {
    return {
      routeManager: (_) => ManagerPage(),
      routePlugin: (_) => PluginUiPage(),
    };
  }

  @override
  Widget index(BuildContext context) {
    return IndexPage();
  }

  @override
  ThemeData style(BuildContext context) {
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
  String title(BuildContext context) {
    return AppLocalizations.of(context).packageName;
  }

  @override
  PreferredSize moveArea(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: WindowMoveArea(),
    );
  }

  @override
  void onError() {}

  @override
  void onHide() {}

  @override
  void onLaunch() {}

  @override
  void onPageNotFound() {}

  @override
  void onShow() {}
}
