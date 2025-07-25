import 'freefeos_platform_interface.dart';

/// An implementation of [FreefeosPlatform] that uses method channels.
class MethodChannelFreefeos extends FreeFEOSPlatform {
  @override
  Future<String?> getPlatformVersion() async {
    return '';
  }
}
