part of '../runtime.dart';

/// 系统运行时实现
final class OSRuntime extends ContextStatefulWrapper {
  const OSRuntime({super.key, this.child});

  final Widget? child;

  @override
  ContextStateWrapper<OSRuntime> createState() {
    return OSRuntimeState();
  }
}
