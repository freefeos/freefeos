part of '../standard.dart';

abstract interface class IOSViewModel implements IfeOSdk, IFreeFEOSSdk {
  /// 附加构建上下文
  // void attachRootBuildContext(BuildContext context);

  /// 获取模块列表
  List<ModuleDetails> get getDetailsList;
}
