part of '../engine.dart';

final class OSEngine extends OSComponent
    with ComponentMixin
    implements IEngine {
  OSEngine();

  /// 日志标签
  static const String _tag = 'OSEngine';

  /// 引擎初始化状态
  bool _instanced = false;

  /// 组件列表
  final List<OSComponent> _componentList = [];

  /// 组件信息列表
  final List<Map<String, String>> _componentInfoList = [];

  /// 组件绑定
  late ComponentBinding _binding;

  /// 引擎入口函数
  @override
  OSEngine call() => this;

  /// 组件ID
  @override
  String get id {
    return resources.getChannel(channel: V.channels.engineChannel);
  }

  /// 组件描述
  @override
  String get description {
    return resources.getString(string: V.strings.engineDescription);
  }

  /// 组件名称
  @override
  String get title {
    return resources.getString(string: V.strings.engineTitle);
  }

  /// 调用组件方法
  @override
  Future<void> onComponentAsyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) async {
    if (call.method ==
        resources.getMethod(method: V.methods.engineGetEngineModules)) {
      if (_instanced) {
        if (_componentInfoList is T) {
          await result.asyncSuccess(_componentInfoList as T);
        } else {
          result.error('', '组件方法调用失败', '组件信息列表类型错误');
        }
      } else {
        result.error('', '组件方法调用失败', '引擎未初始化');
      }
    } else {
      result.notImplemented();
    }
  }

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    if (call.method == resources.getMethod(method: 'execSdkInvoke')) {
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
  Future<void> onCreateEngine(Context context, OSComponent bridge) async {
    if (!_instanced) {
      // 初始化绑定
      _binding = ComponentBinding(context: context, engine: this);
      // 遍历组件列表
      for (var element in [bridge, this, ...components]) {
        // 加载组件
        try {
          await element.onComponentAdded(_binding).then((added) {
            Log.d(tag: _tag, message: '组件${element.id}已加载');
            // 将组件添加进列表
            _componentList.add(element);
            // 将组件信息添加进信息列表
            _componentInfoList.add({
              'id': element.id,
              'title': element.title,
              'description': element.description,
            });
            // 打印提示
            Log.d(tag: _tag, message: '组件${element.id}已添加到组件列表');
            return added;
          });
        } catch (e) {
          Log.e(tag: _tag, message: '组件${element.id}加载失败!\n$e');
        }
      }
      // 将引擎状态设为已加载
      _instanced = true;
    } else {
      // 打印提示
      Log.w(tag: _tag, message: '请勿重复执行onCreateEngine!');
    }
  }

  @override
  Future<void> onDestroyEngine() async {
    if (_instanced) {
      // 清空组件列表
      _componentList.clear();
      // 清空组件信息列表
      _componentInfoList.clear();
      // 将引擎状态设为未加载
      _instanced = false;
    } else {
      Log.d(tag: _tag, message: '请勿重复执行onDestroyEngine!');
    }
  }

  @override
  T? execSyncMethodCall<T>(String id, String method, [arguments]) {
    T? result;
    if (_instanced) {
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
    } else {
      Log.w(tag: _tag, message: '引擎未初始化，无法执行同步方法调用!');
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
    if (_instanced) {
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
    } else {
      Log.w(tag: _tag, message: '引擎未初始化，无法执行异步方法调用!');
    }
    return result;
  }
}
