part of '../base.dart';

/// 应用混入
base mixin AppMixin implements IBase {
  /// 应用
  static late Widget _root;

  /// 获取应用
  @override
  Widget get rootWidget => _root;

  /// 导入应用
  @override
  Future<void> includeApp(Widget child) async => _root = child;
}

base class OSBase extends ContextThemeWrapper {
  /// 构造函数
  const OSBase({super.key, this.child});

  final Widget? child;

  @override
  ContextStateWrapper<OSBase> createState() => OSBaseState<OSBase>();
}

base class OSBaseState<T extends OSBase> extends ContextStateWrapper<T>
    with
        BaseMixin,
        BaseEntry,
        AppMixin,
        // ContextMixin,
        BridgeMixin,
        RuntimeMixin,
        ViewModel
    implements OSModule, FreeFEOSSystem, IBase {
  static const String _tag = 'OSBase';

  /// 模块通道
  @override
  String get moduleChannel {
    return widget.resources.getValues(value: V.channels.baseChannel);
  }

  /// 模块描述
  @override
  String get moduleDescription {
    return widget.resources.getValues(value: V.strings.baseDescription);
  }

  /// 模块名称
  @override
  String get moduleName {
    return widget.resources.getValues(value: V.strings.baseName);
  }

  /// 模块界面
  @override
  Layout moduleWidget(BuildContext context) {
    return buildManager(
      viewModel(context, execSdk),
      widget.child ?? Placeholder(),
    );
  }

  /// 方法调用
  @override
  Future<T?> onModuleAsyncMethodCall<T>(
    String method, [
    dynamic arguments,
  ]) async {
    return await null;
  }

  @override
  T? onModuleSyncMethodCall<T>(String method, [dynamic arguments]) {
    return null;
  }

  // /// 运行应用
  // @protected
  // @override
  // Future<void> entryPoint(List<String> args) async {

  // }

  /// 初始化应用
  @override
  Future<void> init() async {
    return await null;
  }

  /// 获取应用
  @override
  Layout findMiniProgram() {
    return widget.resources.getLayout(builder: (context) => Placeholder());
  }

  @override
  ViewModel viewModel(
    BuildContext buildContext,
    // ContextAttacher contextAttacher,
    SdkInvoker sdkInstance,
  ) {
    return this;
  }

  /// 构建应用
  @override
  Layout buildManager(ViewModel viewModel, Widget userApp) {
    return widget.resources.getLayout(builder: (_) => const Placeholder());
  }

  @override
  Future<T?> getComponentsList<T>() {
    return execModuleAsyncMethodCall(
      widget.resources.getValues(value: V.channels.engineChannel),
      widget.resources.getValues(value: V.methods.engineGetEngineModules),
      {'id': widget.resources.getValues(value: V.channels.engineChannel)},
    );
  }

  @override
  T? execSdk<T>(String apiId, [dynamic arguments]) {
    return execModuleSyncMethodCall(
      widget.resources.getValues(value: V.channels.engineChannel),
      'execSdkInvoke',
      {
        'id': widget.resources.getValues(value: V.channels.engineChannel),
        'apiId': apiId,
        'apiArguments': arguments,
      },
    );
  }

  @override
  Future<T?> execModuleAsyncMethodCall<T>(
    String id,
    String method, [
    arguments,
  ]) async {
    return await null;
  }

  @override
  T? execModuleSyncMethodCall<T>(String id, String method, [arguments]) {
    return null;
  }

  @override
  void initState() {
    super.initState();
    _init().then((result) {
      setState(() {
        flag = true;
      });
    });
  }

  bool flag = false;

  Future<void> _init() async {
    if (flag == false) {
      try {
        // await includeApp(widget.child ?? Placeholder());
        // 初始化日志
        Log.init();
        // 打印横幅
        Log.i(
          tag: _tag,
          message: utf8.decode(
            base64Decode(widget.resources.getValues(value: V.drawable.banner)),
          ),
        );
        // 初始化引擎
        await initEngineBridge().then(
          (_) => bridgeScope.onCreateEngine(widget.baseContext),
          onError: (error) => Log.e(tag: _tag, message: error.toString()),
        );

        // 初始化应用
        await init();

        // 启动
        // await execModuleAsyncMethodCall(
        //   widget.resources.getValues(value: V.channels.engineChannel),
        //   widget.resources.getValues(value: 'execKernelStartup'),
        //   {
        //     'id': widget.resources.getValues(value: V.channels.engineChannel),
        //     'shell': WidgetUtil.layout2Widget(layout: findMiniProgram()),
        //   },
        // );
      } catch (exception) {
        Log.e(tag: _tag, message: exception.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  TransitionBuilder get builder {
    return (_, child) => Container(child: child);
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      return WidgetUtil.layout2Widget(layout: findMiniProgram());
    } else {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    // return Banner(
    //   message: 'FUCK',
    //   location: BannerLocation.topStart,
    //   child: widget.child,
    // );

    // return FutureBuilder<Widget?>(
    //   future: execModuleAsyncMethodCall<Widget>(
    //     widget.resources.getValues(value: V.channels.engineChannel),
    //     widget.resources.getValues(value: 'execKernelStartup'),
    //     {
    //       'id': widget.resources.getValues(value: V.channels.engineChannel),
    //       'shell': WidgetUtil.layout2Widget(layout: findMiniProgram()),
    //     },
    //   ),
    //   initialData: widget.child,
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //       case ConnectionState.active:
    //       case ConnectionState.waiting:
    //         return CircularProgressIndicator.adaptive();
    //       case ConnectionState.done:
    //         if (snapshot.hasError) return Text('Error: ${snapshot.error}');
    //         return Container(color: Color(0xFFFFFFFF), child: snapshot.data);
    //     }
    //   },
    // );
  }
}
