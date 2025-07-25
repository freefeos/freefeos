part of 'loader.dart';

/// Bootloader接口
abstract interface class IOSLoader extends FreeFEOSLoader {
  /// 初始化接口
  Future<void> loadInterface();

  /// 系统启动工作流
  Future<void> workflow();

  /// 系统入口
  TransitionBuilder entryPoint();
}
