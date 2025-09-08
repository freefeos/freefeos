part of '../runtime.dart';

/// 绑定层包装器
abstract interface class IRuntime {
  /// 运行时入口
  FreeFEOSSystem call();

  /// 平台嵌入层模块
  OSModule? get bridge;
}
