import 'package:flutter/material.dart';

import '../base/base.dart';
import '../common/model/model.dart';
import '../common/plugin/plugin_runtime.dart';
import '../common/plugin/plugin_type.dart';
import '../common/types/types.dart';
import '../common/values/channel.dart';
import '../common/values/method.dart';
import '../common/values/placeholder.dart';
import '../common/values/strings.dart';
import '../common/values/tag.dart';
import '../framework/context.dart';
import '../framework/log.dart';
import '../manager/manager.dart';

/// 运行时
final class SystemRuntime extends SystemBase {
  /// 插件列表
  final List<RuntimePlugin> _pluginList = [];

  /// 插件详细信息列表
  final List<PluginDetails> _pluginDetailsList = [];

  /// 内部插件列表
  List<RuntimePlugin> get innerList => [super.base, this, super.embedder];

  /// 插件通道
  @override
  String get pluginChannel => runtimeChannel;

  /// 插件描述
  @override
  String get pluginDescription => runtimeDescription;

  /// 插件名称
  @override
  String get pluginName => runtimeName;

  /// 方法调用
  @override
  Future<dynamic> onMethodCall(
    String method, [
    dynamic arguments,
  ]) async {
    switch (method) {
      case runtimeGetEnginePlugins:
        return await super.execEngine(
          engineGetEnginePlugins,
          arguments,
        );
      default:
        return await null;
    }
  }

  /// 初始化应用
  @override
  Future<void> init(List<RuntimePlugin> plugins) async {
    // 初始化运行时
    await _initRuntime();
    // 初始化引擎插件
    await _initEnginePlugin();
    // 初始化普通插件
    await _initPlugins(plugins: plugins);
  }

  /// 获取App
  @override
  Layout findApplication() {
    // 遍历插件信息列表
    for (var element in _pluginDetailsList) {
      // 判断当前信息是否为运行时
      if (_isRuntime(element)) {
        // 返回运行时的界面
        return resources.getLayout(
          builder: (context) => _getPluginWidget(
            context,
            element,
          ),
        );
      }
    }
    // 当插件信息列表中没有符合的项时直接调用父类方法
    return super.findApplication();
  }

  /// 构建应用
  @override
  Layout build(
    ContextAttacher contextAttacher,
    Widget rootWidget,
  ) {
    return resources.getLayout(
      builder: (_) => ManagerApp(
        contextAttacher: contextAttacher,
        pluginDetailsList: _pluginDetailsList,
        pluginGetter: _getPlugin,
        pluginWidgetGetter: _getPluginWidget,
        runtimeChecker: _isRuntime,
        rootWidget: rootWidget,
      ),
    );
  }

  /// 执行插件方法
  @override
  Future<dynamic> exec(
    String channel,
    String method, [
    dynamic arguments,
  ]) async {
    return await _exec(
      channel,
      method,
      false,
      arguments,
    );
  }

  /// 初始化运行时
  Future<void> _initRuntime() async {
    try {
      // 初始化运行时
      for (var element in innerList) {
        // 类型
        PluginType type = PluginType.unknown;
        // 判断
        switch (element.pluginChannel) {
          case baseChannel:
            type = PluginType.base;
            break;
          case runtimeChannel:
            type = PluginType.runtime;
            break;
          case embedderChannel:
            type = PluginType.embedder;
            break;
          default:
            type = PluginType.unknown;
            break;
        }
        // 添加到内置插件列表
        _pluginList.add(element);
        // 添加到插件详细信息列表
        _pluginDetailsList.add(
          PluginDetails(
            channel: element.pluginChannel,
            title: element.pluginName,
            description: element.pluginDescription,
            author: element.pluginAuthor,
            type: type,
          ),
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  /// 初始化引擎层插件
  Future<void> _initEnginePlugin() async {
    // 初始化平台插件
    try {
      dynamic plugins = await _exec(
        pluginChannel,
        runtimeGetEnginePlugins,
        true,
      );
      List list = plugins as List? ?? [unknownPluginWithMap];
      // 判断列表是否为空
      if (list.isNotEmpty) {
        // 遍历原生插件
        for (var element in list) {
          // 添加到插件详细信息列表
          _pluginDetailsList.add(
            PluginDetails.formMap(
              map: element,
              type: PluginType.engine,
            ),
          );
        }
      }
    } catch (exception) {
      // 平台错误添加未知插件占位
      _pluginDetailsList.add(
        PluginDetails.formMap(
          map: unknownPluginWithMap,
          type: PluginType.unknown,
        ),
      );
    }
  }

  /// 初始化普通插件
  Future<void> _initPlugins({
    required List<RuntimePlugin> plugins,
  }) async {
    try {
      if (plugins.isNotEmpty) {
        for (var element in plugins) {
          _pluginList.add(element);
          _pluginDetailsList.add(
            PluginDetails(
              channel: element.pluginChannel,
              title: element.pluginName,
              description: element.pluginDescription,
              author: element.pluginAuthor,
              type: PluginType.flutter,
            ),
          );
        }
      }
    } catch (_) {
      rethrow;
    }
  }

  /// 判断插件是否为运行时
  bool _isRuntime(PluginDetails details) {
    return details.channel == pluginChannel;
  }

  /// 获取插件
  RuntimePlugin? _getPlugin(PluginDetails details) {
    if (_pluginList.isNotEmpty) {
      for (var element in _pluginList) {
        if (element.pluginChannel == details.channel) {
          return element;
        }
      }
    }
    return null;
  }

  /// 获取插件界面
  Widget _getPluginWidget(
    BuildContext context,
    PluginDetails details,
  ) {
    RuntimePlugin? plugin = _getPlugin(details);
    Widget? pluginWidget = plugin?.pluginWidget(context);
    return pluginWidget ?? const Placeholder();
  }

  /// 执行插件方法
  Future<dynamic> _exec(
    String channel,
    String method,
    bool internal, [
    dynamic arguments,
  ]) async {
    // 判断插件列表是否非空
    if (_pluginList.isNotEmpty) {
      // 遍历插件列表
      for (var element in _pluginList) {
        // 遍历内部插件列表
        for (var internalPlugin in innerList) {
          // 判断是否为内部插件, 且是否不允许访问内部插件
          if (internalPlugin.pluginChannel == channel && !internal) {
            Log.e(
              tag: runtimeTag,
              message: '未经允许的访问!\n'
                  '通道名称:$channel.\n'
                  '方法名称:$method.\n'
                  '附加参数:$arguments.\n',
            );
            // 返回空结束函数
            return await null;
          }
        }
        if (element.pluginChannel == channel) {
          dynamic result;
          try {
            result = await element.onMethodCall(
              method,
              arguments,
            );
          } catch (exception) {
            Log.e(
              tag: runtimeTag,
              message: '运行时插件代码调用失败!\n'
                  '通道名称:$channel.\n'
                  '方法名称:$method.\n'
                  '附加参数:$arguments.\n'
                  '返回结果:$result.',
              error: exception,
            );
            rethrow;
          }
          Log.d(
            tag: runtimeTag,
            message: '运行时插件代码调用成功!\n'
                '通道名称:$channel.\n'
                '方法名称:$method.\n'
                '附加参数:$arguments.\n'
                '返回结果:$result.',
          );
          return await result;
        }
      }
    } else {
      Log.e(
        tag: runtimeTag,
        message: '运行时插件列表为空!',
      );
      return await null;
    }
  }
}
