part of '../engine.dart';

/// 调用输入
final class CallImport implements EngineMethodCall {
  const CallImport({required this.callMethod, required this.callArguments});

  /// 调用方法名称
  final String? callMethod;

  /// 调用方法携带的参数
  final dynamic callArguments;

  /// 获取调用方法名称
  @override
  String? get method => callMethod;

  /// 获取调用方法所携带的参数
  @override
  dynamic get arguments => callArguments;
}
