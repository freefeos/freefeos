part of '../engine.dart';

abstract base class OSComponent extends ContextWrapper {
  OSComponent({super.attach = false});

  /// 组件通道
  late ComponentChannel _componentChannel;

  /// 引擎接口
  late IEngine _engine;

  /// 获取组件通道
  ComponentChannel get getComponentChannel => _componentChannel;

  /// 组件标题
  String get title;

  /// 组件ID
  String get id;

  /// 组件描述
  String get description;

  /// 组件添加时执行
  Future<void> onComponentAdded(ComponentBinding binding) async {
    // 初始化组件通道
    _componentChannel = ComponentChannel(binding: binding, component: this);
    // 附加基础上下文
    attachBaseContext(_componentChannel.getContext());
    // 获取引擎
    _engine = _componentChannel.getEngine();
    // 设置方法回调
    _componentChannel.setMethodCallHandler(this);
  }

  /// 执行组件方法
  Future<void> onComponentAsyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    throw UnimplementedError('未实现onComponentAsyncMethodCall()方法');
  }

  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    throw UnimplementedError('未实现onComponentSyncMethodCall()方法');
  }

  /// 异步执行组件方法
  Future<T?> execAsyncComponentMethod<T>(
    String channel,
    String method, [
    dynamic arguments,
  ]) {
    return _engine.execAsyncMethodCall<T>(channel, method, arguments);
  }

  /// 同步执行组件方法
  T? execSyncComponentMethod<T>(
    String channel,
    String method, [
    dynamic arguments,
  ]) {
    return _engine.execSyncMethodCall<T>(channel, method, arguments);
  }
}
