import '../framework/context.dart';
import '../framework/log.dart';
import '../common/values/channel.dart';
import '../common/values/method.dart';
import '../common/values/strings.dart';
import 'binding.dart';
import 'engine_bridge.dart';
import 'result.dart';
import 'engine_wrapper.dart';
import 'method_call.dart';
import 'plugin_mixin.dart';
import '../common/values/tag.dart';
import 'plugin_engine.dart';

final class SystemEngine extends EnginePlugin
    with PluginMixin
    implements EngineWrapper {
  SystemEngine();

  /// 引擎入口函数
  SystemEngine call() => this;

  /// 引擎初始化状态
  bool initialized = false;

  /// 插件列表
  final List<EnginePlugin> _pluginList = [];

  /// 插件信息列表
  final List<Map<String, dynamic>> _infoList = [];

  /// 插件绑定
  late PluginBinding _binding;

  /// 插件作者
  @override
  String get author => developerName;

  /// 插件通道
  @override
  String get channel => engineChannel;

  /// 插件描述
  @override
  String get description => engineDescription;

  /// 插件名称
  @override
  String get title => engineTitle;

  /// 调用插件方法
  @override
  Future<void> onPluginMethodCall(
    EngineMethodCall call,
    EngineResult result,
  ) async {
    switch (call.method) {
      case engineGetEnginePlugins:
        result.success(
          _infoList,
        );
        break;
      default:
        result.notImplemented();
    }
  }

  @override
  Future<void> onCreateEngine(Context context) async {
    if (initialized == false) {
      // 初始化绑定
      _binding = PluginBinding(
        context: context,
        engine: this,
      );
      // 遍历插件列表
      [
        EngineBridge(),
        this,
        ...plugins,
      ].forEach(load);
      // 将引擎状态设为已加载
      initialized = true;
    } else {
      // 打印提示
      Log.d(
        tag: engineTag,
        message: '请勿重复执行onCreateEngine!',
      );
    }
  }

  Future<void> load(EnginePlugin element) async {
    // 加载插件
    try {
      await element.onPluginAdded(_binding);
      Log.d(
        tag: engineTag,
        message: '插件${element.channel}已加载',
      );
    } catch (e) {
      Log.e(
        tag: engineTag,
        message: '插件${element.channel}添加失败!\n$e',
      );
    }
    // 将插件添加进列表
    _pluginList.add(element);
    _infoList.add({
      'channel': element.channel,
      'title': element.title,
      'description': element.description,
      'author': element.author
    });
    // 打印提示
    Log.d(
      tag: engineTag,
      message: '插件${element.channel}已添加到插件列表',
    );
  }

  @override
  Future<void> onDestroyEngine() async {
    if (initialized == true) {
      _pluginList.clear();
      _infoList.clear();
    } else {
      Log.d(
        tag: engineTag,
        message: '请勿重复执行onDestroyEngine!',
      );
    }
  }

  @override
  Future<dynamic> onMethodCall(
    String methodProxy, [
    dynamic argumentsProxy,
  ]) async {
    return await execMethodCall(
      argumentsProxy['channel'],
      methodProxy,
      argumentsProxy,
    );
  }

  @override
  Future<dynamic> execMethodCall(
    String channel,
    String method, [
    dynamic arguments,
  ]) async {
    dynamic result;
    try {
      for (var element in _pluginList) {
        if (element.getPluginChannel.getChannel() == channel) {
          result = await element.getPluginChannel.execMethodCall(
            channel,
            method,
            arguments,
          );
          Log.d(
            tag: engineTag,
            message: '插件代码调用成功!\n'
                '通道名称:$channel.\n'
                '方法名称:$method.\n'
                '返回结果:$result.',
          );
        }
      }
    } catch (exception) {
      Log.e(
        tag: engineTag,
        message: '插件代码调用失败!\n$exception'
            '通道名称:$channel.\n'
            '方法名称:$method.\n'
            '返回结果:$result.',
      );
    }
    return await result;
  }
}
