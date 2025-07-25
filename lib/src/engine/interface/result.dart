part of '../engine.dart';

abstract interface class EngineResult<T> {
  /// 异步执行成功并返回数据
  Future<void> asyncSuccess(T? result);

  /// 同步执行成功并返回数据
  void syncSuccess(T? result);

  /// 错误
  Never error(String errorCode, String? errorMessage, dynamic errorDetails);

  /// 未实现
  Never notImplemented();
}
