/// freefeos
library;

import 'package:flutter/widgets.dart';

import 'src/common/common.dart';

final class FreeFEOS {
  const FreeFEOS._();

  /// 平台插件注册
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  static void registerWith() {
    return FreeFEOSLoader.instance.registerWith();
  }

  /// FreeFEOS
  static TransitionBuilder get builder {
    return FreeFEOSLoader.instance.builder;
  }
}
