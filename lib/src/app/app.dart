import 'package:flutter/widgets.dart';

import '../pages/manager.dart';
import '../pages/plugin_ui.dart';
import '../values/route.dart';

abstract interface class IAppOption {
  /// 页面
  Map<String, WidgetBuilder> pages();
}

class App implements IAppOption {
  @override
  Map<String, WidgetBuilder> pages() {
    return {
      routeManager: (_) => ManagerPage(),
      routePlugin: (_) => PluginUiPage(),
    };
  }
}
