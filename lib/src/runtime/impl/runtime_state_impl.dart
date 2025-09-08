part of '../runtime.dart';

/// 系统运行时状态实现
final class OSRuntimeState extends ContextStateWrapper<OSRuntime>
    with SystemEntry, RuntimeMixin, BridgeMixin
    implements OSModule, FreeFEOSSystem, IRuntime {
  OSRuntimeState();

  /// Logcat 标签
  static const String _tag = 'OSRuntimeState';

  /// 模块列表
  final List<OSModule> _moduleList = [];

  /// 模块信息列表
  final List<ModuleDetails> _moduleDetailsList = [];

  /// 初始化标志
  final ValueNotifier<bool> _instanced = ValueNotifier(false);

  /// 模块通道
  @override
  String get moduleChannel {
    return resources.getChannel(channel: V.channels.runtimeChannel);
  }

  /// 模块描述
  @override
  String get moduleDescription {
    return resources.getString(string: V.strings.runtimeDescription);
  }

  /// 模块名称
  @override
  String get moduleName {
    return resources.getString(string: V.strings.runtimeName);
  }

  /// 模块界面
  @override
  Layout moduleLayout(BuildContext context) {
    return _buildManager(_viewModel(context));
  }

  @override
  TransitionBuilder get builder {
    return (_, child) => OSRuntime(child: child);
  }

  /// 方法调用
  @override
  Future<T?> onModuleAsyncMethodCall<T>(
    String method, [
    dynamic arguments,
  ]) async {
    if (method ==
        resources.getMethod(method: V.methods.runtimeGetEngineModules)) {
      return await _getComponentsList<T>();
    } else {
      return await null;
    }
  }

  @override
  T? onModuleSyncMethodCall<T>(String method, [arguments]) {
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (!_instanced.value) {
      (() async {
        try {
          await _init(); // 初始化应用
        } catch (exception) {
          Log.e(tag: _tag, message: exception.toString());
        }
      })().then((_) {
        _instanced.value = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 检查是否多次添加进组件树
    _widgetTreeCheck();
  }

  @override
  void dispose() {
    super.dispose();
    if (_instanced.value) {
      (() async {
        try {
          await _destroy(); // 销毁应用
        } catch (exception) {
          Log.e(tag: _tag, message: exception.toString());
        }
      })().then((_) {
        _instanced.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _instanced,
      builder: (_, value, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: value
              ? WidgetUtil.layout2Widget(layout: _findApplication())
              : WidgetUtil.nonNullWidget(child: child),
        );
      },
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  /// 初始化应用
  Future<void> _init() async {
    // 初始化日志
    await Log.init();
    // 打印Banner
    Log.i(
      tag: _tag,
      message: resources.getDrawable(res: V.drawable.banner),
    );
    // 初始化引擎
    await initEngineBridge().then((_) {
      return bridgeScope?.onCreateEngine(baseContext);
    });
    // 初始化运行时
    await _initRuntime();
    // 初始化引擎模块
    await _initComponent();
  }

  /// 销毁应用
  Future<void> _destroy() async {
    Log.i(tag: _tag, message: 'system will exit.');
    // 销毁日志
    await Log.dispose();
    // 销毁引擎
    await bridgeScope?.onDestroyEngine().then((_) {
      return destroyEngineBridge();
    });
    // 清空模块列表
    _moduleList.clear();
    // 清空模块信息列表
    _moduleDetailsList.clear();
  }

  /// 获取App
  Layout _findApplication() {
    return resources.getLayout(
      builder: (context) {
        for (var element in _moduleDetailsList) {
          // 判断当前信息是否为运行时
          if (element.id ==
              resources.getMethod(method: V.channels.runtimeChannel)) {
            // 返回运行时的界面
            return _getModuleWidget(context, element);
          }
        }
        return const Placeholder();
      },
    );
  }

  ViewModel _viewModel(BuildContext buildContext) {
    return OSViewModel(
      context: buildContext,
      sdkInvoker: _execSdk,
      detailsList: _moduleDetailsList,
      child: _buildUserApp,
    );
  }

  Widget get _buildUserApp {
    final Widget? child = widget.child;
    final Widget userApp = WidgetUtil.nonNullWidget(child: child);
    return userApp;
  }

  /// 构建应用
  Layout _buildManager(ViewModel viewModel) {
    return resources.getLayout(
      builder: (_) {
        return App(viewModel: viewModel);
      },
    );
  }

  Future<T?> _getComponentsList<T>() {
    return _execModuleAsyncMethodCall<T>(
      resources.getChannel(channel: V.channels.bridgeChannel),
      resources.getMethod(method: V.methods.engineGetEngineModules),
    );
  }

  T? _execSdk<T>(String apiId, [dynamic arguments]) {
    return _execModuleSyncMethodCall<T>(
      resources.getChannel(channel: V.channels.bridgeChannel),
      'execSdkInvoke',
      {'apiId': apiId, 'apiArguments': arguments},
    );
  }

  /// 检查是否多次添加进组件树
  void _widgetTreeCheck() {
    assert(() {
      if (buildContext.findAncestorWidgetOfExactType<OSRuntime>() != null) {
        throw FlutterError(
          'FreeFEOS.builder 在组件树中只能有一个实例, '
          '请检查代码中是否存在多个 FreeFEOS.builder 实例.',
        );
      }
      return true;
    }());
  }

  /// 初始化运行时
  Future<void> _initRuntime() async {
    if (_moduleList.isEmpty && _moduleDetailsList.isEmpty) {
      try {
        // 初始化运行时
        for (var element in <OSModule>[this, ?bridge]) {
          // 类型
          ModuleType type = ModuleType.unknown;
          if (element.moduleChannel ==
              resources.getChannel(channel: V.channels.runtimeChannel)) {
            type = ModuleType.runtime;
          } else if (element.moduleChannel ==
              resources.getChannel(channel: V.channels.bridgeChannel)) {
            type = ModuleType.bridge;
          } else {
            type = ModuleType.unknown;
          }
          // 添加到内置模块列表
          _moduleList.add(element);
          // 添加到模块详细信息列表
          _moduleDetailsList.add(
            ModuleDetails(
              id: element.moduleChannel,
              title: element.moduleName,
              description: element.moduleDescription,
              type: type,
            ),
          );
        }
      } catch (exception) {
        Log.e(tag: _tag, message: exception.toString());
      }
    } else {
      Log.w(tag: _tag, message: '请勿重复初始化运行时!');
    }
  }

  /// 初始化系统组件
  Future<void> _initComponent() async {
    // 判断模块详细信息列表是否小于等于模块列表
    if (_moduleDetailsList.length <= _moduleList.length) {
      try {
        // 获取模块信息列表
        List<ModuleData>? result =
            await _execModuleAsyncMethodCall<List<ModuleData>>(
              moduleChannel,
              resources.getMethod(method: V.methods.runtimeGetEngineModules),
            );
        // 占位符
        final List<ModuleData> placeholder = [
          resources.getPlaceholder(placeholder: V.placeholder.component),
        ];
        // 如果获取失败, 则使用占位符
        List<ModuleData> componentsList = result ?? placeholder;
        // 判断列表是否为空
        if (componentsList.isNotEmpty) {
          // 遍历系统组件
          for (var component in componentsList) {
            // 添加到详细信息列表
            _moduleDetailsList.add(
              ModuleDetails.formData(
                data: component,
                type: ModuleType.component,
              ),
            );
          }
        }
      } catch (exception) {
        Log.e(tag: _tag, message: exception.toString());
      }
    } else {
      Log.w(tag: _tag, message: '请勿重复初始化系统组件!');
    }
  }

  /// 获取模块
  OSModule? _getModule(ModuleDetails details) {
    if (_moduleList.isNotEmpty) {
      for (var element in _moduleList) {
        if (element.moduleChannel == details.id) {
          return element;
        }
      }
    }
    return null;
  }

  /// 获取模块界面
  Widget _getModuleWidget(BuildContext context, ModuleDetails details) {
    OSModule? module = _getModule(details);
    Layout? layout = module?.moduleLayout(context);
    Layout placeholder = resources.getLayout(
      builder: (_) => const Placeholder(),
    );
    return WidgetUtil.layout2Widget(layout: layout ?? placeholder);
  }

  T? _execModuleSyncMethodCall<T>(String id, String method, [arguments]) {
    // 判断模块列表是否非空
    if (_moduleList.isNotEmpty) {
      // 遍历模块列表
      for (var element in _moduleList) {
        if (element.moduleChannel == id) {
          T? result;
          try {
            result = element.onModuleSyncMethodCall<T>(method, arguments);
          } catch (exception) {
            Log.e(
              tag: _tag,
              message:
                  '运行时模块代码调用失败!\n'
                  '通道名称:$id.\n'
                  '方法名称:$method.\n'
                  '附加参数:$arguments.\n'
                  '返回结果:$result.',
              error: exception,
            );
            rethrow;
          }
          Log.d(
            tag: _tag,
            message:
                '运行时模块代码调用成功!\n'
                '通道名称:$id.\n'
                '方法名称:$method.\n'
                '附加参数:$arguments.\n'
                '返回结果:$result.',
          );
          return result;
        }
      }
    }
    Log.e(tag: _tag, message: '运行时模块列表为空!');
    return null;
  }

  /// 执行模块方法
  Future<T?> _execModuleAsyncMethodCall<T>(
    String id,
    String method, [
    dynamic arguments,
  ]) async {
    // 判断模块列表是否非空
    if (_moduleList.isNotEmpty) {
      // 遍历模块列表
      for (var element in _moduleList) {
        if (element.moduleChannel == id) {
          T? result;
          try {
            result = await element.onModuleAsyncMethodCall<T>(
              method,
              arguments,
            );
          } catch (exception) {
            Log.e(
              tag: _tag,
              message:
                  '运行时模块代码调用失败!\n'
                  '通道名称:$id.\n'
                  '方法名称:$method.\n'
                  '附加参数:$arguments.\n'
                  '返回结果:$result.',
              error: exception,
            );
            rethrow;
          }
          Log.d(
            tag: _tag,
            message:
                '运行时模块代码调用成功!\n'
                '通道名称:$id.\n'
                '方法名称:$method.\n'
                '附加参数:$arguments.\n'
                '返回结果:$result.',
          );
          return result;
        }
      }
    }
    Log.e(tag: _tag, message: '运行时模块列表为空!');
    return await null;
  }
}
