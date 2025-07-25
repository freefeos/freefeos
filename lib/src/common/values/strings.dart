part of '../common.dart';

final class VString {
  const VString();
  // base
  String get baseName => 'OSBase';
  String get baseDescription => '基础层';

  // runtime
  String get runtimeName => 'OSRuntime';
  String get runtimeDescription => '系统运行时';

  // engine
  String get bridgeTitle => 'OSBridge';
  String get bridgeDescription => '引擎桥接';

  String get engineTitle => 'OSEngine';
  String get engineDescription => '系统引擎';

  String get embedderTitle => 'OSEmbedder';
  String get embedderDescription => 'OSEmbedder';
}
