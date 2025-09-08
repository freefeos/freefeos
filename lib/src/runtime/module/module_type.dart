part of '../runtime.dart';

/// 模块类型
enum ModuleType {
  /// 框架运行时
  runtime,

  /// 引擎桥接
  bridge,

  /// 系统组件
  component,

  /// 未知模块类型，用于异常处理
  unknown,
}
