part of '../framework.dart';

abstract base class ContextWrapper implements IContent {
  ContextWrapper({bool attach = true}) {
    if (attach) _mBase = ContextImpl();
  }

  /// 基本上下文
  Context? _mBase;

  /// 构建上下文
  BuildContext? _mBuild;

  /// 附加构建上下文
  @override
  void attachBuildContext(BuildContext context) {
    _mBuild = context;
  }

  /// 附加基本上下文
  @override
  void attachBaseContext(Context base) {
    _mBase = base;
  }

  /// 获取基本上下文
  @override
  Context get baseContext {
    assert(() {
      if (_mBase == null) {
        throw FlutterError('异常: 基本上下文为空!');
      }
      return true;
    }());
    return _mBase!;
  }

  /// 获取构建上下文
  @override
  BuildContext get buildContext {
    assert(() {
      if (_mBuild == null) {
        throw FlutterError('异常: 构建上下文为空!');
      }
      return true;
    }());
    return _mBuild!;
  }

  @override
  void startService(Want want) {
    return _mBase?.startService(want);
  }

  @override
  void stopService(Want want) {
    return _mBase?.stopService(want);
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    return _mBase?.bindService(want, connect);
  }

  @override
  void unbindService(Want want) {
    return _mBase?.unbindService(want);
  }

  @override
  Resources get resources {
    assert(() {
      if (_mBase == null) {
        throw FlutterError('基本上下文为空!');
      }
      return true;
    }());
    return _mBase!.resources;
  }
}
