part of '../common.dart';

/// Flutter兼容层接口
class FreeFEOSCompat extends PlatformInterface {
  FreeFEOSCompat() : super(token: _token);

  /// 接口标志
  static final Object _token = Object();

  /// 接口实例
  static FreeFEOSCompat _instance = FreeFEOSCompat();

  /// 获取接口实例
  static FreeFEOSCompat get instance => _instance;

  /// 设置接口实例
  static set instance(FreeFEOSCompat instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  String get getPackageName {
    throw UnimplementedError('异常: 未实现getAppId接口!');
  }

  String get getAppName {
    throw UnimplementedError('异常: 未实现getAppName接口!');
  }

  String get getVersionName {
    throw UnimplementedError('异常: 未实现getVersion接口!');
  }
}
