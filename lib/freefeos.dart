/// 平台插件注册和API导出
library;

import 'src/export/export.dart';

export 'src/export/export.dart'
    show FreeFEOSPlugin, FreeFEOSExec, FreeFEOSRunner, runFFApp
    hide BaseRegister;

/// 平台插件注册
///
/// 插件注册由Flutter框架接管, 请勿手动注册.
final class FreeFEOSRegister extends BaseRegister {
  const FreeFEOSRegister();

  /// 注册插件
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  static void registerWith() {
    const FreeFEOSRegister()();
  }
}
