part of '../base.dart';

base class OSBase extends ContextStatefulWrapper {
  /// 构造函数
  const OSBase({super.key, this.child});

  final Widget? child;

  @override
  ContextStateWrapper<OSBase> createState() => OSBaseState<OSBase>();
}
