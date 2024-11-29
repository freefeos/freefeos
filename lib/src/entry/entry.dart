import 'package:flutter/widgets.dart';

import '../base/base.dart';
import '../interface/interface.dart';
import '../common/types/types.dart';

final class SystemEntry extends FreeFEOSSystem with BaseEntry {
  SystemEntry();

  /// 入口函数
  @override
  Future<void> runFreeFEOSApp({
    required AppRunner? runner,
    required PluginList? plugins,
    required ApiBuilder? initApi,
    required bool? enabled,
    required Widget app,
    required dynamic error,
  }) async {
    return await () async {
      try {
        return await interface.runFreeFEOSApp(
          runner: runner,
          plugins: plugins,
          initApi: initApi,
          enabled: enabled,
          app: app,
          error: error,
        );
      } catch (exception) {
        return await super.runFreeFEOSApp(
          runner: runner,
          plugins: plugins,
          initApi: initApi,
          enabled: enabled,
          app: app,
          error: exception,
        );
      }
    }();
  }
}
