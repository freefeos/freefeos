/// 插件注册和API导出
library;

import 'package:flutter/widgets.dart';

/// 平台插件注册
///
/// 插件注册由Flutter框架接管, 请勿手动注册.
/// 插件注册由Flutter框架接管, 请勿手动注册.
/// 插件注册由Flutter框架接管, 请勿手动注册.
///
/// 重要的事情说三遍!
///
/// 来来来, 让我看看到底是谁不信邪, 自己又注册一遍?
/// 不要问我注册器是不是公开访问的? 废话! 不公开插件怎么被Flutter注册?
/// 虽然说不听老人言开心好几年, 但是你不听确实会有不可预测的情况出现, 为了代码稳定起见还是别不信邪了.
/// 实在不信邪也可以试试, 崩了跟我可无关. ╮(╯_╰)╭
final class FreeFEOSRegister {
  const FreeFEOSRegister();

  /// 注册插件
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  ///
  /// 重要的事情说三遍!
  static void registerWith() {}
}

final class FreeFEOS {
  const FreeFEOS();

  /// FreeFEOS
  static TransitionBuilder get builder {
    return (_, child) => OSBuilder(child: child);
  }
}

extension LinkBuilder on TransitionBuilder {
  /// 添加其他TransitionBuilder
  TransitionBuilder linkWith(TransitionBuilder builder) {
    return (context, child) => this(context, builder(context, child));
  }
}

class OSBuilder extends StatefulWidget {
  const OSBuilder({super.key, required this.child});

  final Widget? child;

  @override
  State<OSBuilder> createState() => _OSBuilderState();
}

class _OSBuilderState extends State<OSBuilder> {
  _OSBuilderState();

  final FreeFEOSController _freefeos = FreeFEOSController();

  /// 获取内容
  Widget get getChild => widget.child ?? Placeholder();

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: 'FREEFEOS',
      location: BannerLocation.topStart,
      child: getChild,
    );
  }
}

class FreeFEOSController extends ChangeNotifier {
  FreeFEOSController();
}
