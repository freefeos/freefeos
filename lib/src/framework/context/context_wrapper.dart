part of '../framework.dart';

abstract base class ContextThemeWrapper extends StatefulWidget
    with ContextWrapper {
  const ContextThemeWrapper({super.key});
}

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
}

abstract base mixin class ContextWrapper implements Context {
  // ContextWrapper({required bool attach}) {
  //   if (attach) mBase = ContextImpl();
  // }

  /// 基本上下文
  static final Context _base = ContextImpl();

  // /// 构建上下文
  // BuildContext? mBuild;

  // /// 附加构建上下文
  // void attachBuildContext(BuildContext context) {
  //   mBuild = context;
  // }

  // /// 附加基本上下文
  // void attachBaseContext(Context base) {
  //   mBase = base;
  // }

  /// 获取基本上下文
  Context get baseContext {
    return _base;
  }

  // /// 获取构建上下文
  // BuildContext get buildContext {
  //   assert(() {
  //     if (mBuild == null) {
  //       throw FlutterError('异常: 构建上下文为空!');
  //     }
  //     return true;
  //   }());
  //   return mBuild!;
  // }

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
