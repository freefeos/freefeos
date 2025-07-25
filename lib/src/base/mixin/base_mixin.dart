part of '../base.dart';

/// 绑定层混入
base mixin BaseMixin implements IBase {
  /// 获取绑定层实例
  @override
  OSModule get base => OSBaseState();
}
