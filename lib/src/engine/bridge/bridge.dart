part of '../engine.dart';

// TODO: 实现运行时与引擎通过桥接通信
final class OSBridge extends OSComponent with EngineMixin implements IBridge {
  OSBridge();

  /// 组件入口
  @override
  OSBridge call() => this;

  /// 组件通道
  @override
  String get id {
    return resources.getValues(value: V.channels.bridgeChannel);
  }

  /// 组件描述
  @override
  String get description {
    return resources.getValues(value: V.strings.bridgeDescription);
  }

  /// 组件名称
  @override
  String get title {
    return resources.getValues(value: V.strings.bridgeTitle);
  }

  /// 组件方法调用
  @override
  Future<void> onComponentAsyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) async {
    return;
  }

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    return;
  }
}
