part of 'kernel.dart';

/// 内核
final class OSKernel extends OSComponent {
  OSKernel();

  @override
  String get id => 'kernel';

  @override
  String get description => 'feOS内核';

  // @override
  // Future<void> onComponentAsyncMethodCall<T>(
  //   EngineMethodCall call,
  //   EngineResult<T> result,
  // ) async {
  //   if (call.method == resources.getValues(value: 'startup')) {
  //     await _kernelMain<T>(call.arguments['shell']).then(
  //       (res) => result.asyncSuccess(res),
  //       onError: (err) => result.error(err, '', ''),
  //     );
  //   } else {
  //     result.notImplemented();
  //   }
  // }

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

  // Future<T> _kernelMain<T>(dynamic shell) async {
  //   assert(shell is Widget, '异常: shell参数必须是Widget类型!');
  //   await execAsyncComponentMethod(
  //     resources.getValues(value: V.channels.connectChannel),
  //     resources.getValues(value: 'initDonutApi'),
  //   );
  //   // await execAsyncComponentMethod(
  //   //   resources.getValues(value: V.channels.connectChannel),
  //   //   resources.getValues(value: 'runDountApp'),
  //   //   {'app': shell as Widget},
  //   // );
  //   await execAsyncComponentMethod(
  //     resources.getValues(value: V.channels.connectChannel),
  //     resources.getValues(value: 'initDelegate'),
  //   );
  //   return shell as T;
  // }

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

/// 文件
class File {
  /// 内部构造函数
  File._(this._name, this._content);

  /// 文件名
  String _name;

  /// 文件内容
  String _content;

  /// 文件工厂构造函数
  /// fileName 文件名称
  /// content 文件内容
  factory File(String fileName, String content) {
    return File._(fileName, content);
  }

  /// 获取文件名称
  String get getFileName => _name;

  /// 获取文件内容
  String get getFileContent => _content;

  /// 写入文件内容
  set writeContent(String content) {
    _content = content;
  }

  /// 重命名文件
  set renameFile(String name) {
    _name = name;
  }
}

class Directory {
  Directory(this.name);

  final String name;

  final List<File> _files = [];
  final List<Directory> _directories = [];

  void addFile(File file) {
    _files.add(file);
  }

  void addDirectory(Directory directory) {
    _directories.add(directory);
  }

  File? getFile(String name) {
    for (var file in _files) {
      if (file.getFileName == name) {
        return file;
      }
    }
    return null;
  }

  Directory? getDirectory(String name) {
    for (var directory in _directories) {
      if (directory.name == name) {
        return directory;
      }
    }
    return null;
  }

  List<File> get listFiles {
    return _files;
  }

  List<Directory> get listDirectories {
    return _directories;
  }
}

class FileSystem {
  final _rootDirectory = Directory('/');

  List<String> ls(String path) {
    Directory? directory = findDirectory(path);
    if (directory == null) return [];
    return directory.listFiles.map((e) => e.getFileName).toList();
  }

  bool mkdir(String path) {
    var directory = findDirectory(path);
    if (directory == null) return false;
    var fileName = path.split('/').last;
    if (directory.getDirectory(fileName) != null) return false;
    directory.addDirectory(Directory(fileName));
    return true;
  }

  /// 创建文件
  /// path 文件绝对路径
  bool createFile(String path) {
    String parentPath = getParentPath(path);
    String fileName = getFileName(path);
    Directory? parentDirectory = findDirectory(parentPath);
    if (parentDirectory == null) return false;
    if (parentDirectory.getFile(fileName) != null) return false;
    File file = File(fileName, "");
    parentDirectory.addFile(file);
    return true;
  }

  String? cat(String path) {
    File? file = findFile(path);
    if (file != null) {
      return file.getFileContent;
    } else {
      return null;
    }
  }

  bool write(String path, String content) {
    File? file = findFile(path);
    if (file != null) {
      file.writeContent = content;
      return true;
    } else {
      return false;
    }
  }

  Directory? findDirectory(String path) {
    var components = path.split('/');
    var directory = _rootDirectory;
    for (var component in components) {
      if (component.isEmpty) continue;
      var dir = directory.getDirectory(component);
      if (dir == null) return null;
      directory = dir;
    }
    return directory;
  }

  /// 查找文件
  /// path 文件绝对路径
  File? findFile(String path) {
    List<String> components = path.split('/');
    String fileName;

    String? possiblyEmptyFillName = components.lastOrNull;

    if (possiblyEmptyFillName != null) {
      fileName = possiblyEmptyFillName;
    } else {
      return null;
    }

    String directoryPath;

    if (components.length > 1) {
      directoryPath = components.sublist(0, components.length - 1).join('/');
    } else {
      directoryPath = '/';
    }

    Directory? directory = findDirectory(directoryPath);
    if (directory == null) {
      return null;
    }

    return directory.getFile(fileName);
  }

  /// 获取父目录路径
  /// path 文件绝对路径
  String getParentPath(String path) {
    List<String> components = path.split('/');
    if (components.length > 1) {
      return components.sublist(0, components.length - 1).join('/');
    } else {
      return '/';
    }
  }

  /// 获取文件名称
  /// path 文件绝对路径
  String getFileName(String path) {
    return path.split('/').lastOrNull ?? '';
  }
}
