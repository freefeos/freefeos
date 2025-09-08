part of '../common.dart';

final class VString {
  const VString();

  // runtime
  StringRes get runtimeName => 'Runtime';
  StringRes get runtimeDescription => '系统运行时';

  // engine
  StringRes get bridgeTitle => 'Bridge';
  StringRes get bridgeDescription => '引擎桥接';

  StringRes get engineTitle => 'Engine';
  StringRes get engineDescription => '系统引擎';

  StringRes get kernelTitle => 'Kernel';
  StringRes get kernelDescription => '系统内核';

  StringRes get embedderTitle => 'Embedder';
  StringRes get embedderDescription => '平台嵌入';

  StringRes get standardTitle => 'Standard';
  StringRes get standardDescription => '标准库';
}
