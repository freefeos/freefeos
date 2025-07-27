part of '../framework.dart';

final class ContextImpl implements Context {
  const ContextImpl();

  static const Resources _resources = Resources();

  @override
  void startService(Want want) {
    return want.getService().onCreate();
  }

  @override
  void stopService(Want want) {
    return want.getService().onDestroy();
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    return connect.onServiceConnected(
      want.classes.toString(),
      want.getService().onBind(want),
    );
  }

  @override
  void unbindService(Want want) {
    want.getService().onUnbind(want);
  }

  @override
  Resources get resources {
    return _resources;
  }
}
