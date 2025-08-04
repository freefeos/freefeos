part of '../common.dart';

// BL接口
abstract base class FreeFEOSLoader extends PlatformInterface {
  FreeFEOSLoader() : super(token: _token);

  /// 接口标志
  static final Object _token = Object();

  /// 获取接口实例
  static FreeFEOSLoader get instance => OSLoader();

  /// 接口注册
  void registerWith() {
    throw UnimplementedError('异常: 未实现registerWith()接口!');
  }

  /// 获取构建器
  TransitionBuilder get builder {
    throw UnimplementedError('异常: 未实现builder接口!');
  }
}
