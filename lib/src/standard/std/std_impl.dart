part of '../standard.dart';

final class OSStandard extends OSComponent {
  @override
  String get title => 'OSSdk';

  @override
  String get description => 'OSSdk';

  @override
  String get id => 'system_sdk';

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    result.notImplemented();
    // if (call.method == 'getAppName') {
    //   result.syncSuccess(_execSysCall(CallForm.getAppName));
    // } else if (call.method == 'getPackageName') {
    //   result.syncSuccess(_execSysCall(CallForm.getPackageName));
    // } else if (call.method == 'getVersionName') {
    //   result.syncSuccess(_execSysCall(CallForm.getVersionName));
    // } else {
    //   result.notImplemented();
    // }

    // if (call.method == 'addThemeModeChangeListener') {
    //   result.syncSuccess(
    //     _execSysCall(CallForm.addThemeModeChangeListener, call.arguments),
    //   );
    // } else if (call.method == 'setClipboardData') {
    //   result.syncSuccess(
    //     _execSysCall(CallForm.setClipboardData, call.arguments),
    //   );
    // } else if (call.method == 'openSetting') {
    //   result.syncSuccess(_execSysCall(CallForm.openSetting, call.arguments));
    // } else if (call.method == 'openCustomer') {
    //   result.syncSuccess(_execSysCall(CallForm.openCustomer, call.arguments));
    // } else if (call.method == 'setAppShareInfo') {
    //   result.syncSuccess(
    //     _execSysCall(CallForm.setAppShareInfo, call.arguments),
    //   );
    // } else if (call.method == 'openEKit') {
    //   result.syncSuccess(_execSysCall(CallForm.openEKit, call.arguments));
    // } else if (call.method == 'openWeChat') {
    //   result.syncSuccess(_execSysCall(CallForm.openWeChat, call.arguments));
    // } else if (call.method == 'getNavigatorObserver') {
    //   result.syncSuccess(_execSysCall(CallForm.getNavigatorObserver));
    // } else if (call.method == 'getThemeMode') {
    //   result.syncSuccess(_execSysCall(CallForm.getThemeMode));
    // } else if (call.method == 'getAppBarTheme') {
    //   result.syncSuccess(_execSysCall(CallForm.getAppBarTheme));
    // } else if (call.method == 'checkEnv') {
    //   result.syncSuccess(_execSysCall(CallForm.checkEnv));
    // } else if (call.method == 'getAppId') {
    //   result.syncSuccess(_execSysCall(CallForm.getAppId));
    // } else if (call.method == 'getVersionStage') {
    //   result.syncSuccess(_execSysCall(CallForm.getVersionStage));
    // } else if (call.method == 'getVersionName') {
    //   result.syncSuccess(_execSysCall(CallForm.getVersionName));
    // } else if (call.method == 'getHostAppVersion') {
    //   result.syncSuccess(_execSysCall(CallForm.getHostAppVersion));
    // } else if (call.method == 'getBaseSdkVersion') {
    //   result.syncSuccess(_execSysCall(CallForm.getBaseSdkVersion));
    // } else {
    //   result.notImplemented();
    // }
  }

  T? _execSysCall<T>(CallForm form, [dynamic arguments]) {
    return execSyncComponentMethod<T>('kernel', 'syscall', {
      'callForm': form,
      'callArguments': arguments,
    });
  }
}
