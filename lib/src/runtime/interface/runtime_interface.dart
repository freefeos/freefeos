part of '../runtime.dart';

/// 绑定层包装器
abstract interface class IRuntime {
  /// 运行时入口
  FreeFEOSSystem call();

  // /// 初始化
  // Future<void> init();

  /// 平台嵌入层模块
  OSModule? get engine;

  // /// 图形界面
  // Layout findApplication();

  // /// 系统能力ViewModel
  // ViewModel viewModel(
  //   BuildContext buildContext,
  //   SdkInvoker sdkInstance,
  //   Widget? child,
  // );

  // /// 构建App
  // Layout buildManager(ViewModel viewModel);

  // /// 系统组件列表
  // Future<T?> getComponentsList<T>();

  // /// 执行SDk
  // T? execSdk<T>(String apiId, [dynamic arguments]);

  // Future<T?> execModuleAsyncMethodCall<T>(
  //   String id,
  //   String method, [
  //   dynamic arguments,
  // ]);

  // T? execModuleSyncMethodCall<T>(String id, String method, [dynamic arguments]);
}
