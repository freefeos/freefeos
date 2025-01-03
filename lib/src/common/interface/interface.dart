import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../framework/log.dart';
import '../types/types.dart';
import '../values/tag.dart';

/// 实现平台接口的抽象类
class FreeFEOSSystem extends PlatformInterface {
  FreeFEOSSystem() : super(token: _token);

  /// 令牌
  static final Object _token = Object();

  /// 默认实现
  static final FreeFEOSSystem _default = FreeFEOSSystem();

  /// 实例
  static FreeFEOSSystem _instance = _default;

  /// 获取实例
  static FreeFEOSSystem get instance => _instance;

  /// 设置实例
  static set instance(FreeFEOSSystem instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// 实现的接口
  FreeFEOSSystem get interface => instance;

  /// 运行应用
  Future<void> runFreeFEOSApp({
    required AppRunner? runner,
    required PluginList? plugins,
    required ApiBuilder? initApi,
    required bool? enabled,
    required Widget app,
    required dynamic error,
  }) async {
    return error == null
        ? enabled ?? true
            ? () async {
                try {
                  await (initApi ?? (_) async {})(
                    (
                      String channel,
                      String method, [
                      dynamic arguments,
                    ]) async {
                      Log.w(
                        tag: entryTag,
                        message: '不支持当前平台,\n'
                            '当前调用的插件通道: $channel,\n'
                            '方法名: $method,\n'
                            '携带参数: $arguments,\n'
                            '无法执行操作, 将返回空.',
                      );
                      return await null;
                    },
                  );
                  return await (runner ?? (Widget app) async => runApp(app))(
                    app,
                  ).then(
                    (_) => Log.w(
                      tag: entryTag,
                      message: '不支持当前平台,\n'
                          '框架所有代码将不会参与执行,\n'
                          '${(plugins ?? []).length}个插件不会被加载.\n',
                    ),
                  );
                } catch (exception) {
                  throw FlutterError(exception.toString());
                }
              }()
            : (runner ?? (Widget app) async => runApp(app))(app)
        : throw FlutterError(error.toString());
  }
}

class FreeFEOSPlatform extends PlatformInterface {
  FreeFEOSPlatform() : super(token: _token);

  static final Object _token = Object();

  static FreeFEOSPlatform _instance = FreeFEOSPlatform();

  static FreeFEOSPlatform get instance => _instance;

  static set instance(FreeFEOSPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List?> getPlatformPluginList() async {
    throw UnimplementedError('异常: 未实现getPlatformPluginList()接口!');
  }

  Future<bool?> openPlatformDialog() async {
    throw UnimplementedError('异常: 未实现openPlatformDialog()接口!');
  }

  Future<bool?> closePlatformDialog() async {
    throw UnimplementedError('异常: 未实现closePlatformDialog()接口!');
  }
}
