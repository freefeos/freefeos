part of 'loader.dart';

final class OSEntry extends FreeFEOSSystem with BaseEntry {
  OSEntry();

  /// 入口函数
  @override
  TransitionBuilder entryPoint() {
    try {
      return interface.entryPoint();
    } catch (_) {
      return super.entryPoint();
    }
  }
}
