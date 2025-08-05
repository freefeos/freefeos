part of '../runtime.dart';

/// 运行时
final class OSRuntime extends ContextStatefulWrapper {
  const OSRuntime({super.key, this.child});

  final Widget? child;

  @override
  ContextStateWrapper<OSRuntime> createState() {
    return OSRuntimeState();
  }
}
