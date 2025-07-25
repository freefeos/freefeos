/// Web 插件注册
library;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/common/common.dart';

/// Web 插件注册
final class FreeFEOSWeb {
  const FreeFEOSWeb();

  /// Web 插件注册
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  ///
  /// 重要的事情说三遍!
  ///
  /// 来来来, 让我看看到底是谁不信邪, 自己又注册一遍?
  /// 不要问我注册器是不是公开访问的? 废话! 不公开插件怎么被Flutter注册?
  /// 虽然说不听老人言开心好几年, 但是你不听确实会有不可预测的情况出现,
  /// 为了代码稳定起见还是别不信邪了. 实在不信邪也可以试试,
  /// 崩了跟我可无关. ╮(╯_╰)╭
  static void registerWith(Registrar _) {
    FreeFEOSLoader.instance.registerWith();
  }
}
