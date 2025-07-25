part of '../engine.dart';

/// 模块绑定器
final class ComponentBinding {
  const ComponentBinding({required this.context, required this.engine});

  /// 上下文
  final Context context;

  /// 引擎
  final IEngine engine;

  /// 获取上下文
  Context getContext() {
    return context;
  }

  /// 获取引擎
  IEngine getEngine() {
    return engine;
  }
}
