part of 'kernel.dart';

/// 内核
final class OSKernel extends OSComponent {
  OSKernel();

  @override
  String get id => 'kernel';

  @override
  String get description => 'feOS Kernel';

  @override
  String get title => 'OSKernel';

  @override
  Future<void> onComponentAdded(ComponentBinding binding) {
    return super.onComponentAdded(binding).then((added) async {
      await _kernelMain();
      return added;
    });
  }

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    if (call.method == resources.getValues(value: 'syscall')) {
      result.syncSuccess(
        _syscall(call.arguments['callForm'], call.arguments['callArguments']),
      );
    } else {
      result.notImplemented();
    }
  }

  Future<void> _kernelMain() async {
    await _buildRootFS();
  }

  final FileSystem _fs = FileSystem();

  Future<void> _buildRootFS() async {
    _fs.createFile('/hello_fs.txt');
    _fs.write('/hello_fs.txt', 'hello world');
    var ls = _fs.ls('/');
    var cat = _fs.cat('/hello_fs.txt');
    debugPrint(ls.toString());
    debugPrint(cat.toString());
  }

  T? _syscall<T>(CallForm form, [dynamic arguments]) {
    switch (form) {
      default:
        return null;
      // case CallForm.getAppName:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getAppName',
      //     arguments,
      //   );
      // case CallForm.getPackageName:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getPackageName',
      //     arguments,
      //   );
      // case CallForm.getVersionName:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getVersionName',
      //     arguments,
      //   );

      // case CallForm.addThemeModeChangeListener:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'addThemeModeChangeListener',
      //     arguments,
      //   );
      // case CallForm.setClipboardData:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'setClipboardData',
      //     arguments,
      //   );
      // case CallForm.openSetting:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'openSetting',
      //     arguments,
      //   );
      // case CallForm.openCustomer:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'openCustomer',
      //     arguments,
      //   );
      // case CallForm.setAppShareInfo:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'setAppShareInfo',
      //     arguments,
      //   );
      // case CallForm.openEKit:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'openEKit',
      //     arguments,
      //   );
      // case CallForm.openWeChat:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'openWeChat',
      //     arguments,
      //   );
      // case CallForm.getNavigatorObserver:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getNavigatorObserver',
      //     arguments,
      //   );
      // case CallForm.getThemeMode:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getThemeMode',
      //     arguments,
      //   );
      // case CallForm.getAppBarTheme:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getAppBarTheme',
      //     arguments,
      //   );
      // case CallForm.checkEnv:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'checkEnv',
      //     arguments,
      //   );
      // case CallForm.getAppId:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getAppId',
      //     arguments,
      //   );
      // case CallForm.getVersionStage:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getVersionStage',
      //     arguments,
      //   );
      // case CallForm.getVersionName:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getVersionName',
      //     arguments,
      //   );
      // case CallForm.getHostAppVersion:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getHostAppVersion',
      //     arguments,
      //   );
      // case CallForm.getBaseSdkVersion:
      //   return execSyncComponentMethod<T>(
      //     resources.getValues(value: V.channels.connectChannel),
      //     'getBaseSdkVersion',
      //     arguments,
      //   );
    }
  }
}
