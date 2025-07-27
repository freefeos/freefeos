part of '../framework.dart';

abstract base class ContextStateWrapper<T extends ContextStatefulWrapper>
    extends State<T>
    implements Context {
  ContextStateWrapper();

  @override
  void bindService(Want want, ServiceConnection connect) {
    return widget.bindService(want, connect);
  }

  @override
  void startService(Want want) {
    return widget.startService(want);
  }

  @override
  void stopService(Want want) {
    return widget.stopService(want);
  }

  @override
  void unbindService(Want want) {
    return widget.unbindService(want);
  }

  @override
  Resources get resources {
    return widget.resources;
  }

  /// 获取基本上下文
  @override
  Context get baseContext {
    return widget.baseContext;
  }
}
