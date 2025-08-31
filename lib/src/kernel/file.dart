part of 'kernel.dart';

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
