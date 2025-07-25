import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'freefeos_method_channel.dart';

abstract class FreefeosPlatform extends PlatformInterface {
  /// Constructs a FreefeosPlatform.
  FreefeosPlatform() : super(token: _token);

  static final Object _token = Object();

  static FreefeosPlatform _instance = MethodChannelFreefeos();

  /// The default instance of [FreefeosPlatform] to use.
  ///
  /// Defaults to [MethodChannelFreefeos].
  static FreefeosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FreefeosPlatform] when
  /// they register themselves.
  static set instance(FreefeosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
