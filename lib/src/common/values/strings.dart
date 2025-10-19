part of '../common.dart';

final class VString {
  const VString();

  // runtime
  StringRes get runtimeName => 'Runtime';
  StringRes get runtimeDescription => '系统运行时实现.';

  // engine
  StringRes get bridgeTitle => 'Bridge';
  StringRes get bridgeDescription => '引擎桥接, 用于与系统运行时与引擎的交互.';

  StringRes get engineTitle => 'Engine';
  StringRes get engineDescription => '系统引擎实现.';

  StringRes get kernelTitle => 'Kernel';
  StringRes get kernelDescription => '库操作系统内核实现.';

  StringRes get embedderTitle => 'Embedder';
  StringRes get embedderDescription => '平台嵌入, 用于与Flutter底层交互.';

  StringRes get standardTitle => 'Standard';
  StringRes get standardDescription => '标准库, 提供基础的功能.';

  StringRes get multipleInstancesError =>
      'FreeFEOS.builder 在组件树中只能有一个实例, '
      '请检查代码中是否存在多个 FreeFEOS.builder 实例.';
}
