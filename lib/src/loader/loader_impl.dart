part of 'loader.dart';

// Bootloader
final class OSLoader extends IOSLoader {
  OSLoader();

  /// feOS, 启动！
  @override
  Future<void> boot(List<String> args) async {
    workflow();
  }

  @override
  Future<void> workflow() async {
    await loadInterface();
    await entryPoint();
  }

  /// 初始化接口
  @override
  Future<void> loadInterface() async {
    FreeFEOSCompat.instance = DonutCompat();
    FreeFEOSSystem.instance = OSEntry();
  }

  @override
  TransitionBuilder entryPoint() {
    return FreeFEOSSystem.instance.builder;
  }
}
