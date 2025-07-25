part of '../engine.dart';

/// 引擎包装器
abstract interface class IEngine implements OSModule, EngineProxy {
  /// 引擎入口
  OSEngine call();

  /// 执行方法
  Future<T?> execAsyncMethodCall<T>(
    String id,
    String method, [
    dynamic arguments,
  ]);

  T? execSyncMethodCall<T>(String id, String method, [dynamic arguments]);
}
