part of '../framework.dart';

abstract interface class Context {
  /// 启动服务
  void startService(Want want);

  /// 停止服务
  void stopService(Want want);

  /// 绑定服务
  void bindService(Want want, ServiceConnection connect);

  /// 解绑服务
  void unbindService(Want want);

  /// 获取资源
  Resources get resources;
}
