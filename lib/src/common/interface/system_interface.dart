part of '../common.dart';

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

  /// 接口实例
  FreeFEOSSystem get interface => instance;

  /// 入口函数
  TransitionBuilder get builder {
    throw UnimplementedError('异常: 未实现builder接口!');
  }
}
