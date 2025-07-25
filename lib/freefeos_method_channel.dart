import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'freefeos_platform_interface.dart';

/// An implementation of [FreefeosPlatform] that uses method channels.
class MethodChannelFreefeos extends FreefeosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('freefeos');

  @override
  Future<String?> getPlatformVersion() async {
    return '';
  }
}
