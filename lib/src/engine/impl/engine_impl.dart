part of '../engine.dart';

final class OSEngine extends OSComponent
    with ComponentMixin
    implements IEngine {
  OSEngine();

  /// 引擎初始化状态
  bool initialized = false;

  /// 组件列表
  final List<OSComponent> _componentList = [];

  /// 组件信息列表
  final List<Map<String, dynamic>> _componentInfoList = [];

  /// 组件绑定
  late ComponentBinding _binding;

  /// 日志标签
  static const String _tag = 'OSEngine';

  /// 引擎入口函数
  @override
  OSEngine call() => this;

  /// 获取引擎
  @override
  OSModule get getEngine => this();

  @override
  String get moduleChannel {
    return resources.getValues(value: V.channels.engineChannel);
  }

  @override
  String get moduleDescription {
    return resources.getValues(value: V.strings.engineDescription);
  }

  @override
  String get moduleName {
    return resources.getValues(value: V.strings.engineTitle);
  }

  @override
  Layout moduleWidget(BuildContext context) {
    return resources.getLayout(builder: (_) => const Placeholder());
  }

  /// 组件ID
  @override
  String get id {
    return resources.getValues(value: V.channels.engineChannel);
  }

  /// 组件描述
  @override
  String get description {
    return resources.getValues(value: V.strings.engineDescription);
  }

  /// 组件名称
  @override
  String get title {
    return resources.getValues(value: V.strings.engineTitle);
  }

  /// 调用组件方法
  @override
  Future<void> onComponentAsyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) async {
    if (call.method ==
        resources.getValues(value: V.methods.engineGetEngineModules)) {
      if (_componentInfoList is T) {
        await result.asyncSuccess(_componentInfoList as T);
      } else {
        result.error('', '组件方法调用失败', '组件信息列表类型错误');
      }
    } else if (call.method == resources.getValues(value: 'execKernelStartup')) {
      await execAsyncComponentMethod<T>(
        resources.getValues(value: kernel.id),
        resources.getValues(value: 'startup'),
        {
          resources.getValues(value: 'shell'):
              call.arguments[resources.getValues(value: 'shell')],
        },
      ).then(
        (res) => result.asyncSuccess(res),
        onError: (error) {
          result.error('', '组件方法调用失败', error.toString());
        },
      );
    } else {
      result.notImplemented();
    }
  }

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    if (call.method == resources.getValues(value: 'execSdkInvoke')) {
      result.syncSuccess(
        execSyncComponentMethod<T>(
          sdk.id,
          call.arguments['apiId'],
          call.arguments['apiArguments'],
        ),
      );
    } else {
      result.notImplemented();
    }
  }

  @override
  Future<void> onCreateEngine(Context context) async {
    if (initialized == false) {
      // 初始化绑定
      _binding = ComponentBinding(context: context, engine: this);
      // 遍历组件列表
      for (var element in [this, OSBridge(), ...components]) {
        // 加载组件
        try {
          await element.onComponentAdded(_binding).then((added) {
            Log.d(tag: _tag, message: '组件${element.id}已加载');
            // 将组件添加进列表
            _componentList.add(element);
            // 引擎本身已经作为运行时模块, 不在组件列表中展示
            if (element.id != id) {
              _componentInfoList.add({
                'id': element.id,
                'title': element.title,
                'description': element.description,
              });
            }
            // 打印提示
            Log.d(tag: _tag, message: '组件${element.id}已添加到组件列表');
            return added;
          });
        } catch (e) {
          Log.e(tag: _tag, message: '组件${element.id}加载失败!\n$e');
        }
      }
      // 将引擎状态设为已加载
      initialized = true;
    } else {
      // 打印提示
      Log.e(tag: _tag, message: '请勿重复执行onCreateEngine!');
    }
  }

  @override
  Future<void> onDestroyEngine() async {
    if (initialized == true) {
      _componentList.clear();
      _componentInfoList.clear();
    } else {
      Log.d(tag: _tag, message: '请勿重复执行onDestroyEngine!');
    }
  }

  @override
  T? execSyncMethodCall<T>(String id, String method, [arguments]) {
    T? result;
    try {
      for (var element in _componentList) {
        if (element.getComponentChannel.getId() == id) {
          result = element.getComponentChannel.execSyncMethodCall<T>(
            id,
            method,
            arguments,
          );
          Log.d(
            tag: _tag,
            message:
                '组件代码调用成功!\n'
                '组件ID:$id.\n'
                '方法名称:$method.\n'
                '返回结果:$result.',
          );
        }
      }
    } catch (exception) {
      Log.e(
        tag: _tag,
        message:
            '组件代码调用失败!\n$exception'
            '组件ID:$id.\n'
            '方法名称:$method.\n'
            '返回结果:$result.',
      );
    }
    return result;
  }

  @override
  Future<T?> execAsyncMethodCall<T>(
    String id,
    String method, [
    dynamic arguments,
  ]) async {
    T? result;
    try {
      for (var element in _componentList) {
        if (element.getComponentChannel.getId() == id) {
          result = await element.getComponentChannel.execAsyncMethodCall<T>(
            id,
            method,
            arguments,
          );
          Log.d(
            tag: _tag,
            message:
                '组件代码调用成功!\n'
                '组件ID:$id.\n'
                '方法名称:$method.\n'
                '返回结果:$result.',
          );
        }
      }
    } catch (exception) {
      Log.e(
        tag: _tag,
        message:
            '组件代码调用失败!\n$exception'
            '组件ID:$id.\n'
            '方法名称:$method.\n'
            '返回结果:$result.',
      );
    }
    return result;
  }

  @override
  Future<T?> onModuleAsyncMethodCall<T>(String method, [dynamic arguments]) {
    return execAsyncMethodCall<T>(id, method, arguments);
  }

  @override
  T? onModuleSyncMethodCall<T>(String method, [dynamic arguments]) {
    return execSyncMethodCall<T>(id, method, arguments);
  }
}
