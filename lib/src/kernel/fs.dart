part of 'kernel.dart';

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
