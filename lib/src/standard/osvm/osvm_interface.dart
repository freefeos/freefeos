part of '../standard.dart';

abstract interface class IOSViewModel implements IfeOSdk, IFreeFEOSSdk {
  /// 获取模块列表
  List<ModuleDetails> get getDetailsList;
}
