/// freefeos_web
library;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/common/common.dart';

final class FreeFEOSWeb {
  const FreeFEOSWeb._();

  /// Web 插件注册
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  static void registerWith(Registrar _) {
    return FreeFEOSLoader.instance.registerWith();
  }
}
