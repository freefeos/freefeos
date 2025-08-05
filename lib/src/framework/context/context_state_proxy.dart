part of '../framework.dart';

base mixin ContextStateProxy<T extends ContextStatefulWrapper> on State<T>
    implements IContent {
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

  @override
  void attachBaseContext(Context base) {
    return widget.attachBaseContext(base);
  }

  @override
  void attachBuildContext(BuildContext context) {
    return widget.attachBuildContext(context);
  }

  @override
  Context get baseContext {
    return widget.baseContext;
  }

  @override
  BuildContext get buildContext {
    return widget.buildContext;
  }

  @override
  void didChangeDependencies() {
    attachBuildContext(context);
    super.didChangeDependencies();
  }
}
