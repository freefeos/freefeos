part of '../engine.dart';

/// 返回结果输入
final class ResultImport<T> implements EngineResult<T> {
  const ResultImport({this.asyncCallback, this.syncCallback});

  /// 异步回调
  final Future<void> Function(T? result)? asyncCallback;

  /// 同步回调
  final void Function(T? result)? syncCallback;

  /// 成功
  @override
  Future<void> asyncSuccess(T? result) {
    assert(asyncCallback != null, 'asyncCallback is null');
    return asyncCallback!(result);
  }

  @override
  void syncSuccess(T? result) {
    assert(syncCallback != null, 'syncCallback is null');
    return syncCallback!(result);
  }

  /// 错误
  @override
  Never error(String errorCode, String? errorMessage, dynamic errorDetails) {
    throw FlutterError(
      '错误代码:$errorCode\n'
      '错误消息:$errorMessage\n'
      '详细信息:$errorDetails',
    );
  }

  /// 未实现
  @override
  Never notImplemented() {
    throw UnimplementedError('notImplemented');
  }
}
