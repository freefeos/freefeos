part of '../engine.dart';

/// 引擎代理
abstract interface class EngineProxy {
  /// 获取模块
  OSModule get getEngine;

  /// 创建引擎
  Future<void> onCreateEngine(Context context);

  /// 销毁引擎
  Future<void> onDestroyEngine();
}
