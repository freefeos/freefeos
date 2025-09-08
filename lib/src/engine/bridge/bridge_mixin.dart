part of '../engine.dart';

/// 引擎桥接
base mixin BridgeMixin implements IBridgeMixin {
  /// 引擎桥接
  OSBridge? _engineBridge;

  /// 初始化引擎桥接
  @override
  Future<void> initEngineBridge() async {
    _engineBridge = OSBridge()();
  }

  @override
  Future<void> destroyEngineBridge() async {
    _engineBridge = null;
  }

  /// 获取引擎桥接
  @override
  EngineMixin? get bridgeScope => _engineBridge;

  /// 获取引擎模块实例
  @override
  OSModule? get bridge => _engineBridge;
}
