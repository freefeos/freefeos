part of '../engine.dart';

/// 引擎混入
base mixin EngineMixin on OSComponent implements EngineProxy {
  /// 引擎
  static final OSEngine _engineScope = OSEngine()();

  /// 初始化引擎
  @override
  Future<void> onCreateEngine(Context context) {
    return _engineScope.onCreateEngine(context, this);
  }

  /// 销毁引擎
  @override
  Future<void> onDestroyEngine() {
    return _engineScope.onDestroyEngine();
  }
}
