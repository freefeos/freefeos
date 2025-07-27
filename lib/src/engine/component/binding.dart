part of '../engine.dart';

/// 模块绑定器
final class ComponentBinding {
  const ComponentBinding({required this.context, required this.engine});

  final Context context;

  /// 引擎
  final IEngine engine;

  Context getContext() {
    return context;
  }

  /// 获取引擎
  IEngine getEngine() {
    return engine;
  }
}
