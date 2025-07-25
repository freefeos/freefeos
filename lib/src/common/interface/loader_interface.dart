part of '../common.dart';

class FreeFEOSLoader extends PlatformInterface {
  FreeFEOSLoader() : super(token: _token);

  /// 接口标志
  static final Object _token = Object();

  /// 获取接口实例
  static FreeFEOSLoader get instance => OSLoader();

  /// 启动
  Future<void> boot(List<String> args) {
    throw UnimplementedError('异常: 未实现boot()接口！');
  }
}
