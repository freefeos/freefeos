import 'package:flutter/widgets.dart';

import 'want.dart';
import 'service.dart';

final class Layout extends Widget {
  const Layout({
    super.key,
    required this.layout,
  });

  /// Widget
  final Widget layout;

  @override
  Element createElement() {
    return LayoutElement(
      this,
      layout,
    );
  }
}

class LayoutElement extends ComponentElement {
  LayoutElement(
    super.widget,
    this.layout,
  );

  /// Widget
  final Widget layout;

  @override
  Widget build() => layout;

  @override
  void update(Layout newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}

final class LayoutFrame extends StatelessWidget {
  const LayoutFrame({
    super.key,
    required this.layout,
  });

  final Layout layout;

  @override
  Widget build(BuildContext context) {
    return Container(child: layout);
  }
}

final class Resources {
  const Resources();

  Layout getLayout({
    required WidgetBuilder builder,
  }) {
    return Layout(
      layout: Builder(builder: builder),
    );
  }

  dynamic getValues({
    required dynamic value,
  }) {
    return value;
  }
}

abstract base class Context {
  void startService(Want want);
  void stopService(Want want);
  void bindService(Want want, ServiceConnection connect);
  void unbindService(Want want);
  Resources get resources;
}

final class ContextImpl extends Context {
  static const res = Resources();

  @override
  void startService(Want want) {
    want.getService().onCreate();
  }

  @override
  void stopService(Want want) {
    want.getService().onDestroy();
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    var a = want.getService().onBind(want);
    connect.onServiceConnected(want.classes.toString(), a);
  }

  @override
  void unbindService(Want want) {
    want.getService().onUnbind(want);
  }

  @override
  Resources get resources => res;
}

base class ContextWrapper extends Context {
  ContextWrapper({
    required bool attach,
  }) {
    if (attach) mBase = ContextImpl();
  }

  /// 基本上下文
  Context? mBase;

  /// 构建上下文
  BuildContext? mBuild;

  /// 附加构建上下文
  void attachBuildContext(BuildContext context) {
    mBuild = context;
  }

  /// 附加基本上下文
  void attachBaseContext(Context base) {
    mBase = base;
  }

  /// 获取基本上下文
  Context get baseContext {
    assert(() {
      if (mBase == null) {
        throw FlutterError('异常: 基本上下文为空!');
      }
      return true;
    }());
    return mBase!;
  }

  /// 获取构建上下文
  BuildContext get buildContext {
    assert(() {
      if (mBuild == null) {
        throw FlutterError('异常: 构建上下文为空!');
      }
      return true;
    }());
    return mBuild!;
  }

  @override
  void startService(Want want) {
    mBase?.startService(want);
  }

  @override
  void stopService(Want want) {
    mBase?.stopService(want);
  }

  @override
  void bindService(Want want, ServiceConnection connect) {
    mBase?.bindService(want, connect);
  }

  @override
  void unbindService(Want want) {
    mBase?.unbindService(want);
  }

  @override
  Resources get resources {
    assert(() {
      if (mBase == null) {
        throw FlutterError(
          '基本上下文为空!',
        );
      }
      return true;
    }());
    return mBase!.resources;
  }
}
