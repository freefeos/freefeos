import 'package:flutter/widgets.dart';

import '../sdk/option.dart';
import 'pages/index.dart';
import 'pages/manager.dart';
import 'pages/plugin_ui.dart';
import 'route.dart';

class App implements IAppOption {
  /// 页面
  @override
  Map<String, WidgetBuilder> pages() {
    return {
      routeIndex: (_) => IndexPage(),
      routeManager: (_) => ManagerPage(),
      routePlugin: (_) => PluginUiPage(),
    };
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