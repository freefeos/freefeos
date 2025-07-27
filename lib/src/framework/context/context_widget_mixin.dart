part of '../framework.dart';

base mixin ContextWidgetMixin on Widget implements IContent {
  static final WrapperConstruct _construct = WrapperConstruct();

  @override
  void attachBaseContext(Context base) {
    return _construct.attachBaseContext(base);
  }

  @override
  void attachBuildContext(BuildContext context) {
    return _construct.attachBuildContext(context);
  }

  @override
  Context get baseContext {
    return _construct.baseContext;
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    return _construct.bindService(want, connect);
  }

  @override
  BuildContext get buildContext {
    return _construct.buildContext;
  }

  @override
  Resources get resources {
    return _construct.resources;
  }

  @override
  void startService(Want want) {
    return _construct.startService(want);
  }

  @override
  void stopService(Want want) {
    return _construct.stopService(want);
  }

  @override
  void unbindService(Want want) {
    return _construct.unbindService(want);
  }
}
