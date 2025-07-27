part of '../base.dart';

base class OSBase extends ContextStatefulWrapper {
  /// 构造函数
  const OSBase({super.key, this.child});

  final Widget? child;

  @override
  ContextStateWrapper<OSBase> createState() => OSBaseState<OSBase>();
}

base class OSBaseState<W extends OSBase> extends ContextStateWrapper<W>
    with BaseEntry, BridgeMixin, RuntimeMixin, ViewModel
    implements OSModule, FreeFEOSSystem, IBase {
  OSBaseState();

  static const String _tag = 'OSBase';
  bool _initializationFlag = false;

  /// 模块通道
  @override
  String get moduleChannel {
    return resources.getValues(value: V.channels.baseChannel);
  }

  /// 模块描述
  @override
  String get moduleDescription {
    return resources.getValues(value: V.strings.baseDescription);
  }

  /// 模块名称
  @override
  String get moduleName {
    return resources.getValues(value: V.strings.baseName);
  }

  /// 模块界面
  @override
  Layout moduleWidget(BuildContext context) {
    return buildManager(viewModel(context, execSdk, widget.child));
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

  /// 初始化应用
  @override
  Future<void> init() async {
    return await null;
  }

  /// 获取应用
  @override
  Layout findMiniProgram() {
    return resources.getLayout(builder: (context) => const Placeholder());
  }

  @override
  ViewModel viewModel(
    BuildContext buildContext,
    SdkInvoker sdkInstance,
    Widget? child,
  ) {
    return this;
  }

  /// 构建应用
  @override
  Layout buildManager(ViewModel viewModel) {
    return resources.getLayout(builder: (_) => const Placeholder());
  }

  @override
  Future<T?> getComponentsList<T>() {
    return execModuleAsyncMethodCall(
      resources.getValues(value: V.channels.engineChannel),
      resources.getValues(value: V.methods.engineGetEngineModules),
      {'id': resources.getValues(value: V.channels.engineChannel)},
    );
  }

  @override
  T? execSdk<T>(String apiId, [dynamic arguments]) {
    return execModuleSyncMethodCall(
      resources.getValues(value: V.channels.engineChannel),
      'execSdkInvoke',
      {
        'id': resources.getValues(value: V.channels.engineChannel),
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
    if (!_initializationFlag) {
      (() async {
        try {
          // 初始化日志
          Log.init();
          // 打印横幅
          Log.i(
            tag: _tag,
            message: utf8.decode(
              base64Decode(resources.getValues(value: V.drawable.banner)),
            ),
          );
          // 初始化引擎
          await initEngineBridge().then(
            (_) => bridgeScope.onCreateEngine(baseContext),
            onError: (error) => Log.e(tag: _tag, message: error.toString()),
          );
          // 初始化应用
          await init();
        } catch (exception) {
          Log.e(tag: _tag, message: exception.toString());
        }
      })().then((_) {
        if (mounted) {
          setState(() {
            _initializationFlag = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    bridgeScope.onDestroyEngine();
  }

  @override
  TransitionBuilder get builder {
    return (_, child) => OSBase(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return _initializationFlag
        ? WidgetUtil.layout2Widget(layout: findMiniProgram())
        : const Center(child: CircularProgressIndicator.adaptive());
  }
}
