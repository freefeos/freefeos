part of '../base.dart';

/// 绑定层包装器
abstract interface class IBase {
  /// 运行时入口
  FreeFEOSSystem call();

  /// 初始化
  Future<void> init();

  /// 绑定通信层模块
  OSModule get base;

  /// 平台嵌入层模块
  OSModule get engine;

  /// 图形界面
  Layout findMiniProgram();

  /// 系统能力ViewModel
  ViewModel viewModel(
    BuildContext buildContext,
    SdkInvoker sdkInstance,
    Widget? child,
  );

  /// 构建App
  Layout buildManager(ViewModel viewModel);

  /// 系统组件列表
  Future<T?> getComponentsList<T>();

  /// 执行SDk
  T? execSdk<T>(String apiId, [dynamic arguments]);

  Future<T?> execModuleAsyncMethodCall<T>(
    String id,
    String method, [
    dynamic arguments,
  ]);

  T? execModuleSyncMethodCall<T>(String id, String method, [dynamic arguments]);
}
