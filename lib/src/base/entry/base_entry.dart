part of '../base.dart';

/// 入口混入
base mixin BaseEntry implements FreeFEOSSystem {
  /// 执行接口
  @override
  FreeFEOSSystem get interface => OSBaseState()();
}
