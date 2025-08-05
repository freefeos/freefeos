part of '../runtime.dart';

/// 入口混入
base mixin SystemEntry implements FreeFEOSSystem {
  /// 执行接口
  @override
  FreeFEOSSystem get interface => OSRuntimeState()();
}
