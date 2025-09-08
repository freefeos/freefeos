part of '../engine.dart';

final class OSBridge extends OSComponent
    with EngineMixin
    implements IBridge, OSModule {
  OSBridge({super.attach = true});

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

  @override
  String get moduleChannel {
    return resources.getValues(value: V.channels.bridgeChannel);
  }

  @override
  String get moduleDescription => '桥接模块';

  @override
  Layout moduleLayout(BuildContext context) {
    return resources.getLayout(builder: (_) => const Placeholder());
  }

  @override
  String get moduleName => 'Bridge';

  @override
  Future<T?> onModuleAsyncMethodCall<T>(String method, [dynamic arguments]) {
    return execAsyncComponentMethod<T>(
      resources.getValues(value: V.channels.engineChannel),
      method,
      arguments,
    );
  }

  @override
  T? onModuleSyncMethodCall<T>(String method, [dynamic arguments]) {
    return execSyncComponentMethod<T>(
      resources.getValues(value: V.channels.engineChannel),
      method,
      arguments,
    );
  }
}
