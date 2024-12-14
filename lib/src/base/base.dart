import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../embedder/embedder_mixin.dart';
import '../engine/bridge_mixin.dart';
import '../framework/context.dart';
import '../kernel/kernel.dart';
import '../plugin/plugin_runtime.dart';
import '../common/types/types.dart';
import '../common/utils/utils.dart';
import '../common/values/channel.dart';
import '../common/values/values.dart';
import '../common/values/strings.dart';
import '../common/values/tag.dart';
import '../framework/log.dart';
import '../common/interface/interface.dart';
import '../runtime/runtime_mixin.dart';
import '../server/server.dart';

/// 绑定层包装器
abstract interface class ISystemBase {
  /// 运行时入口
  FreeFEOSSystem call();

  /// 初始化
  Future<void> init(List<RuntimePlugin> plugins);

  /// 绑定通信层插件
  RuntimePlugin get base;

  /// 平台嵌入层插件
  RuntimePlugin get embedder;

  /// 用户App
  Widget get rootWidget;

  /// 导入用户App
  Future<void> includeApp(Widget child);

  /// 获取带有导航主机的上下文
  BuildContext get context;

  /// 附加带有导航主机的上下文
  void attachContext(BuildContext host);

  /// 获取App
  Layout findApplication();

  /// 构建App
  Layout build(
    ContextAttacher contextAttacher,
    Widget rootWidget,
  );

  /// 执行引擎插件方法
  Future<dynamic> execEngine(
    String method, [
    dynamic arguments,
  ]);

  /// 执行插件方法
  Future<dynamic> exec(
    String channel,
    String method, [
    dynamic arguments,
  ]);
}

/// 应用混入
base mixin AppMixin implements ISystemBase {
  /// 应用
  static late Widget _root;

  /// 获取应用
  @override
  Widget get rootWidget => _root;

  /// 导入应用
  @override
  Future<void> includeApp(Widget child) async => _root = child;
}

/// 入口混入
base mixin BaseEntry implements FreeFEOSSystem {
  /// 执行接口
  @override
  FreeFEOSSystem get interface => SystemBase()();
}

/// 绑定层混入
base mixin BaseMixin implements ISystemBase {
  /// 获取绑定层实例
  @override
  RuntimePlugin get base => SystemBase();
}

/// 上下文混入
base mixin ContextMixin on ContextWrapper implements ISystemBase {
  /// 获取带有导航主机的上下文
  @override
  BuildContext get context {
    return super.buildContext;
  }

  /// 附加导航主机上下文
  @override
  void attachContext(BuildContext host) {
    super.attachBuildContext(host);
  }
}

base class SystemBase extends ContextWrapper
    with
        ContextMixin,
        AppMixin,
        RuntimeMixin,
        BaseEntry,
        BaseMixin,
        EmbedderMixin,
        KernelBridgeMixin,
        ServerBridgeMixin,
        EngineBridgeMixin,
        ViewModel
    implements RuntimePlugin, FreeFEOSSystem, KernelModule, ISystemBase {
  /// 构造函数
  SystemBase() : super(attach: true);

  /// 插件作者
  @override
  String get pluginAuthor => developerName;

  /// 插件通道
  @override
  String get pluginChannel => baseChannel;

  /// 插件描述
  @override
  String get pluginDescription => baseDescription;

  /// 插件名称
  @override
  String get pluginName => baseName;

  /// 插件界面
  @override
  Widget pluginWidget(BuildContext context) {
    return build(
      super.attachContext,
      super.rootWidget,
    );
  }

  /// 方法调用
  @override
  Future<dynamic> onMethodCall(
    String method, [
    dynamic arguments,
  ]) async {
    return await null;
  }

  /// 运行应用
  @mustCallSuper
  @protected
  @override
  Future<void> runFreeFEOSApp({
    required AppRunner? runner,
    required PluginList? plugins,
    required ApiBuilder? initApi,
    required bool? enabled,
    required Widget app,
    required dynamic error,
  }) async {
    // 判断是否启用框架, 如果在浏览器中运行不启用.
    return enabled ?? true && !PlatformUtil.kIsWebBrowser
        // 导入App
        ? includeApp(app).then(
            (_) async {
              try {
                // 初始化日志
                Log.init();
                // 打印横幅
                Log.d(
                  tag: baseTag,
                  message: utf8.decode(
                    base64Decode(
                      resources.getValues(
                        value: V.drawable.banner,
                      ),
                    ),
                  ),
                );
                // 初始化控件绑定
                WidgetsFlutterBinding.ensureInitialized();
                // 初始化窗口管理
                if (PlatformUtil.kIsDesktop) {
                  await windowManager.ensureInitialized();
                }
                // 初始化内核桥接
                await initKernelBridge();
                // 初始化内核
                await kernelBridgeScope.onCreateKernel();
                // 初始化服务桥接
                await initServerBridge();
                // 初始化服务
                await serverBridgeScope.onCreateServer();
                // 初始化引擎桥接
                await initEngineBridge();
                // 初始化引擎
                await engineBridgerScope.onCreateEngine(baseContext);
                // 初始化应用
                await init(plugins ?? <RuntimePlugin>[]);
                // 初始化API
                await (initApi ?? (_) async {})(
                  (
                    String channel,
                    String method, [
                    dynamic arguments,
                  ]) async {
                    return await () async {
                      return await exec(
                        channel,
                        method,
                        arguments,
                      );
                    }();
                  },
                );
                // 初始化窗口相关
                if (PlatformUtil.kIsDesktop) {
                  await windowManager.waitUntilReadyToShow(
                    const WindowOptions(
                      size: null,
                      center: true,
                      minimumSize: Size(600, 400),
                      maximumSize: null,
                      alwaysOnTop: false,
                      fullScreen: false,
                      backgroundColor: null,
                      skipTaskbar: false,
                      title: null,
                      titleBarStyle: TitleBarStyle.hidden,
                      windowButtonVisibility: true,
                    ),
                    () async {
                      await windowManager.show();
                      await windowManager.focus();
                    },
                  );
                }
                // 调用运行器启动应用
                return await (runner ?? (Widget app) async => runApp(app))(
                  WidgetUtil.layout2Widget(findApplication()),
                );
              } catch (_) {
                // 断言没有传入异常
                assert(() {
                  if (error != null) {
                    throw FlutterError('error not is null.');
                  }
                  return true;
                }());
                // 重新抛出异常
                rethrow;
              }
            },
          )
        // 未启用框架时直接调用运行器启动应用
        : (runner ?? (Widget app) async => runApp(app))(app);
  }

  /// 初始化应用
  @override
  Future<void> init(List<RuntimePlugin> plugins) async {
    return await null;
  }

  /// 获取应用
  @override
  Layout findApplication() {
    return resources.getLayout(
      builder: pluginWidget,
    );
  }

  /// 构建应用
  @override
  Layout build(
    ContextAttacher contextAttacher,
    Widget rootWidget,
  ) {
    return resources.getLayout(
      builder: (_) => const Placeholder(),
    );
  }

  /// 执行引擎方法
  @protected
  @override
  Future<dynamic> execEngine(
    String method, [
    dynamic arguments,
  ]) async {
    return await engineBridgerScope.onMethodCall(
      method,
      {'channel': engineChannel, ...?arguments},
    );
  }

  /// 执行方法
  @override
  Future<dynamic> exec(
    String channel,
    String method, [
    dynamic arguments,
  ]) async {
    return await null;
  }
}
