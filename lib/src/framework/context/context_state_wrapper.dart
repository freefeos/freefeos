part of '../framework.dart';

abstract class ContextStateWrapper<T extends ContextThemeWrapper>
    extends State<T>
    implements Context {
  @override
  void bindService(Want want, ServiceConnection connect) {
    widget.bindService(want, connect);
  }

  @override
  void startService(Want want) {
    widget.startService(want);
  }

  @override
  void stopService(Want want) {
    widget.stopService(want);
  }

  @override
  void unbindService(Want want) {
    widget.unbindService(want);
  }

  @override
  Resources get resources => widget.resources;

  /// 获取基本上下文
  Context get baseContext {
    return widget.baseContext;
  }
}
