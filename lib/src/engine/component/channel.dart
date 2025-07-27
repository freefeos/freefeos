part of '../engine.dart';

/// 模块通道
final class ComponentChannel {
  ComponentChannel({required this.binding, required this.component});

  /// 组件绑定
  final ComponentBinding binding;

  /// 组件实例
  final OSComponent component;

  /// 组件
  OSComponent? _component;

  /// 设置调用
  void setMethodCallHandler(OSComponent handler) {
    _component = handler;
  }

  /// 获取组件ID
  String getId() {
    return component.id;
  }

  Context getContext() {
    return binding.getContext();
  }

  /// 获取引擎
  IEngine getEngine() {
    return binding.getEngine();
  }

  /// 执行方法
  Future<T?> execAsyncMethodCall<T>(
    String name,
    String method, [
    dynamic arguments,
  ]) async {
    T? result;
    if (name == getId()) {
      await _component?.onComponentAsyncMethodCall<T>(
        CallImport(callMethod: method, callArguments: arguments),
        ResultImport<T>(asyncCallback: (T? res) async => result = res),
      );
    }
    return result;
  }

  T? execSyncMethodCall<T>(String name, String method, [dynamic arguments]) {
    T? result;
    if (name == getId()) {
      _component?.onComponentSyncMethodCall<T>(
        CallImport(callMethod: method, callArguments: arguments),
        ResultImport<T>(syncCallback: (T? res) => result = res),
      );
    }
    return result;
  }
}
