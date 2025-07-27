part of '../runtime.dart';

/// 运行时
final class OSRuntime extends OSBase {
  const OSRuntime({super.key, super.child});

  @override
  ContextStateWrapper<OSRuntime> createState() => OSRuntimeState<OSRuntime>();
}
