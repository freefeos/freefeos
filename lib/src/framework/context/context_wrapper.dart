part of '../framework.dart';

abstract base mixin class ContextWrapper implements Context {
  const ContextWrapper();

  static const Context _base = ContextImpl();

  @override
  void startService(Want want) {
    return _base.startService(want);
  }

  @override
  void stopService(Want want) {
    return _base.stopService(want);
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    return _base.bindService(want, connect);
  }

  @override
  void unbindService(Want want) {
    return _base.unbindService(want);
  }

  @override
  Resources get resources {
    return _base.resources;
  }

  @override
  Context get baseContext {
    return _base.baseContext;
  }
}
