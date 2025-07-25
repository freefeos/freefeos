part of '../runtime.dart';

/// 运行时混入
base mixin RuntimeMixin implements IBase {
  /// 获取运行时实例
  @override
  FreeFEOSSystem call() => OSRuntimeState();
}
