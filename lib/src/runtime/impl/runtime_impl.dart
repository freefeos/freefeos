part of '../runtime.dart';

/// 运行时
final class OSRuntime extends OSBase {
  const OSRuntime({super.key, super.child});

  @override
  ContextStateWrapper<OSRuntime> createState() => OSRuntimeState<OSRuntime>();
}

final class OSRuntimeState<T extends OSRuntime> extends OSBaseState<T> {
  OSRuntimeState();

  /// Logcat 标签
  static const String _tag = 'OSRuntime';

  /// 模块列表
  final List<OSModule> _moduleList = [];

  /// 模块详细信息列表
  final List<ModuleDetails> _moduleDetailsList = [];

  /// 内部模块列表
  List<OSModule> get innerList {
    return [
      // OSBaseState(),
      // super.base, // 基础层
      this, // 运行时
      super.engine, // 引擎层
    ];
  }

  /// 模块通道
  @override
  String get moduleChannel {
    return resources.getValues(value: V.channels.runtimeChannel);
  }

  /// 模块描述
  @override
  String get moduleDescription {
    return resources.getValues(value: V.strings.runtimeDescription);
  }

  /// 模块名称
  @override
  String get moduleName {
    return resources.getValues(value: V.strings.runtimeName);
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
        resources.getValues(value: V.methods.runtimeGetEngineModules)) {
      return await getComponentsList<T>();
    } else {
      return await null;
    }
  }

  @override
  T? onModuleSyncMethodCall<T>(String method, [arguments]) {
    return null;
  }

  /// 初始化应用
  @override
  Future<void> init() async {
    Log.d(tag: _tag, message: 'init()');
    Log.d(tag: _tag, message: '_initRuntime()');
    // 初始化运行时
    await _initRuntime();
    Log.d(tag: _tag, message: '_initComponent()');
    // 初始化引擎模块
    await _initComponent();
  }

  /// 获取App
  @override
  Layout findMiniProgram() {
    // 遍历模块信息列表
    for (var element in _moduleDetailsList) {
      // 判断当前信息是否为运行时
      if (element.id == moduleChannel) {
        // 返回运行时的界面
        return resources.getLayout(
          builder: (context) {
            return _getModuleWidget(context, element);
          },
        );
      }
    }
    // 当模块信息列表中没有符合的项时直接调用父类方法
    return super.findMiniProgram();
  }

  @override
  ViewModel viewModel(
    BuildContext buildContext,
    // ContextAttacher contextAttacher,
    SdkInvoker sdkInstance,
  ) {
    return OSViewModel(
      context: buildContext,
      // contextAttacher: contextAttacher,
      sdkInvoker: sdkInstance,
      detailsList: _moduleDetailsList,
    );
  }

  /// 构建应用
  @override
  Layout buildManager(ViewModel viewModel, Widget userApp) {
    return resources.getLayout(builder: (_) => App(viewModel: viewModel));
  }

  /// 初始化运行时
  Future<void> _initRuntime() async {
    try {
      final String base = resources.getValues(value: V.channels.baseChannel);
      final String runtime = resources.getValues(
        value: V.channels.runtimeChannel,
      );
      final String engine = resources.getValues(
        value: V.channels.engineChannel,
      );
      // 初始化运行时
      for (var element in innerList) {
        // 类型
        ModuleType type = ModuleType.unknown;
        if (element.moduleChannel == base) {
          type = ModuleType.base;
        } else if (element.moduleChannel == runtime) {
          type = ModuleType.runtime;
        } else if (element.moduleChannel == engine) {
          type = ModuleType.engine;
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
        Log.d(tag: _tag, message: _moduleList.toString());
      }
    } catch (exception) {
      Log.e(tag: _tag, message: exception.toString());
    }
  }

  /// 初始化系统组件
  Future<void> _initComponent() async {
    try {
      List<Map<String, dynamic>>? result =
          await execModuleAsyncMethodCall<List<Map<String, dynamic>>>(
            moduleChannel,
            resources.getValues(value: V.methods.runtimeGetEngineModules),
          );
      final List<Map<String, dynamic>> placeholder = [
        resources.getValues(value: V.placeholder.component),
      ];
      assert(result is List<Map<String, dynamic>>, '错误: 数据类型不符合!');
      List<Map<String, dynamic>> componentsList = result ?? placeholder;
      // 判断列表是否为空
      if (componentsList.isNotEmpty) {
        // 遍历系统组件
        for (var component in componentsList) {
          // 添加到详细信息列表
          _moduleDetailsList.add(
            ModuleDetails.formMap(map: component, type: ModuleType.component),
          );
        }
      }
    } catch (exception) {
      Log.e(tag: _tag, message: exception.toString());
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
    Widget? moduleWidget = module?.moduleWidget(context);
    return moduleWidget ?? const Placeholder();
  }

  @override
  T? execModuleSyncMethodCall<T>(String id, String method, [arguments]) {
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
  @override
  Future<T?> execModuleAsyncMethodCall<T>(
    String id,
    String method, [
    dynamic arguments,
  ]) async {
    Log.d(tag: _tag, message: 'execModuleAsyncMethodCall');
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
