part of '../engine.dart';

/// 引擎桥接接口
/// 实现 [IOSBase] 中的 [engine] 接口
/// 并实现了两个供 [OSBase] 使用的接口
/// [initEngineBridge] 和 [engineBridgerScope]
abstract interface class IBridgeMixin implements IRuntime {
  /// 初始化引擎桥接
  Future<void> initEngineBridge();

  Future<void> destroyEngineBridge();

  /// 引擎桥接域
  OSBridge? get bridgeScope;
}
