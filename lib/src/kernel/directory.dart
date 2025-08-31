part of 'kernel.dart';

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
