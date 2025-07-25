part of '../engine.dart';

/// 方法调用
abstract interface class EngineMethodCall {
  String? get method;
  dynamic get arguments;
}
