part of '../common.dart';

final class VString {
  const VString();
  // base
  StringRes get baseName => 'OSBase';
  StringRes get baseDescription => '基础层';

  // runtime
  StringRes get runtimeName => 'OSRuntime';
  StringRes get runtimeDescription => '系统运行时';

  // engine
  StringRes get bridgeTitle => 'OSBridge';
  StringRes get bridgeDescription => '引擎桥接';

  StringRes get engineTitle => 'OSEngine';
  StringRes get engineDescription => '系统引擎';

  StringRes get embedderTitle => 'OSEmbedder';
  StringRes get embedderDescription => 'OSEmbedder';
}
