part of '../framework.dart';

abstract base mixin class ContextWrapper implements Context {
  /// 基本上下文
  static final Context _base = ContextImpl();

  /// 获取基本上下文
  Context get baseContext {
    return _base;
  }

  @override
  void startService(Want want) {
    _base.startService(want);
  }

  @override
  void stopService(Want want) {
    _base.stopService(want);
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    _base.bindService(want, connect);
  }

  @override
  void unbindService(Want want) {
    _base.unbindService(want);
  }

  @override
  Resources get resources {
    return _base.resources;
  }
}
