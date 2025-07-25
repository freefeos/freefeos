part of 'kernel.dart';

/// 内核
final class OSKernel extends OSComponent {
  OSKernel();

  @override
  String get id => 'kernel';

  @override
  String get description => 'feOS内核';

  @override
  Future<void> onComponentAsyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) async {
    if (call.method == resources.getValues(value: 'startup')) {
      await _kernelMain<T>(call.arguments['shell']).then(
        (res) => result.asyncSuccess(res),
        onError: (err) => result.error(err, '', ''),
      );
    } else {
      result.notImplemented();
    }
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

  @override
  String get title => 'OSKernel';

  Future<T> _kernelMain<T>(dynamic shell) async {
    assert(shell is Widget, '异常: shell参数必须是Widget类型!');
    await execAsyncComponentMethod(
      resources.getValues(value: V.channels.connectChannel),
      resources.getValues(value: 'initDonutApi'),
    );
    // await execAsyncComponentMethod(
    //   resources.getValues(value: V.channels.connectChannel),
    //   resources.getValues(value: 'runDountApp'),
    //   {'app': shell as Widget},
    // );
    await execAsyncComponentMethod(
      resources.getValues(value: V.channels.connectChannel),
      resources.getValues(value: 'initDelegate'),
    );
    return shell as T;
  }

  T? _syscall<T>(CallForm form, [dynamic arguments]) {
    switch (form) {
      case CallForm.addThemeModeChangeListener:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'addThemeModeChangeListener',
          arguments,
        );
      case CallForm.setClipboardData:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'setClipboardData',
          arguments,
        );
      case CallForm.openSetting:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'openSetting',
          arguments,
        );
      case CallForm.openCustomer:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'openCustomer',
          arguments,
        );
      case CallForm.setAppShareInfo:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'setAppShareInfo',
          arguments,
        );
      case CallForm.openEKit:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'openEKit',
          arguments,
        );
      case CallForm.openWeChat:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'openWeChat',
          arguments,
        );
      case CallForm.getNavigatorObserver:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getNavigatorObserver',
          arguments,
        );
      case CallForm.getThemeMode:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getThemeMode',
          arguments,
        );
      case CallForm.getAppBarTheme:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getAppBarTheme',
          arguments,
        );
      case CallForm.checkEnv:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'checkEnv',
          arguments,
        );
      case CallForm.getAppId:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getAppId',
          arguments,
        );
      case CallForm.getVersionStage:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getVersionStage',
          arguments,
        );
      case CallForm.getVersionName:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getVersionName',
          arguments,
        );
      case CallForm.getHostAppVersion:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getHostAppVersion',
          arguments,
        );
      case CallForm.getBaseSdkVersion:
        return execSyncComponentMethod<T>(
          resources.getValues(value: V.channels.connectChannel),
          'getBaseSdkVersion',
          arguments,
        );
    }
  }
}

class File {
  const File(this.name, this.content);

  final String name;
  final String content;
}

class Directory {
  Directory(this.name);

  final String name;

  final List<File> files = [];
  final List<Directory> directories = [];

  void addFile(File file) {
    files.add(file);
  }

  void addDirectory(Directory directory) {
    directories.add(directory);
  }

  File? getFile(String name) {
    for (var file in files) {
      if (file.name == name) {
        return file;
      }
    }
    return null;
  }

  Directory? getDirectory(String name) {
    for (var directory in directories) {
      if (directory.name == name) {
        return directory;
      }
    }
    return null;
  }

  List<File> listFiles() {
    return files.toList();
  }

  List<Directory> listDirectories() {
    return directories.toList();
  }
}

class FileSystem {
  final _rootDirectory = Directory('/');

  List<String> ls(String path) {
    var directory = findDirectory(path);
    if (directory == null) return [];
    return directory.listFiles().map((e) => e.name).toList();
  }

  Directory? findDirectory(String path) {
    var current = _rootDirectory;
    var parts = path.split('/');
    for (var part in parts) {
      if (part.isEmpty) continue;
      var directory = current.getDirectory(part);
      if (directory == null) return null;
      current = directory;
    }
    return current;
  }

  File? findFile(String path) {
    var directory = findDirectory(path);
    if (directory == null) return null;
    var fileName = path.split('/').last;
    return directory.getFile(fileName);
  }

  String getParentPath(String path) {
    var parts = path.split('/');
    if (parts.length <= 1) return '/';
    return parts.sublist(0, parts.length - 1).join('/');
  }

  String getFileName(String path) {
    return path.split('/').last;
  }
}
