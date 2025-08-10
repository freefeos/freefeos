part of '../runtime.dart';

abstract interface class OSModule {
  ///模块通道
  String get moduleChannel;

  ///模块名称
  String get moduleName;

  ///模块描述
  String get moduleDescription;

  ///模块界面
  Layout moduleLayout(BuildContext context);

  ///方法调用
  Future<T?> onModuleAsyncMethodCall<T>(String method, [dynamic arguments]);

  /// 同步调用
  T? onModuleSyncMethodCall<T>(String method, [dynamic arguments]);
}
