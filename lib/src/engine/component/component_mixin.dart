part of '../engine.dart';

/// 组件列表
base mixin ComponentMixin {
  /// 组件列表
  List<OSComponent> get components {
    return [kernel, embedder, sdk];
  }

  OSComponent get kernel => OSKernel();

  OSComponent get embedder => OSEmbedder();

  OSComponent get sdk => OSStandard();
}
