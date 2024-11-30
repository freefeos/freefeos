import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freefeos/src/common/interface/interface.dart';
import 'package:freefeos/src/plugin/plugin_runtime.dart';
import 'package:freefeos/src/common/types/types.dart';
import 'package:freefeos/src/common/values/strings.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class MockFreeFEOSInterface
    with MockPlatformInterfaceMixin
    implements FreeFEOSSystem, RuntimePlugin {
  bool isInitialized = false;

  @override
  FreeFEOSSystem get interface => this;

  @override
  Future<void> runFreeFEOSApp({
    required AppRunner? runner,
    required PluginList? plugins,
    required ApiBuilder? initApi,
    required bool? enabled,
    required Widget app,
    required dynamic error,
  }) async {
    isInitialized = true;
  }

  @override
  String get pluginAuthor => developerName;

  @override
  String get pluginChannel => 'system_interface_test';

  @override
  String get pluginDescription => '系统接口单元测试';

  @override
  String get pluginName => '系统接口单元测试';

  @override
  Widget pluginWidget(BuildContext context) {
    return const Placeholder();
  }

  @override
  Future onMethodCall(String method, [arguments]) async {
    return await null;
  }
}

/// 系统接口单元测试
void main() {
  final FreeFEOSSystem initialInterface = FreeFEOSSystem.instance;

  test('$FreeFEOSSystem 是默认实例.', () {
    expect(initialInterface, isInstanceOf<FreeFEOSSystem>());
  });

  test('runFreeFEOSApp 接口调用正常.', () async {
    MockFreeFEOSInterface fakeInterface = MockFreeFEOSInterface();
    FreeFEOSSystem.instance = fakeInterface;
    await FreeFEOSSystem.instance.runFreeFEOSApp(
      runner: (app) async => runApp(app),
      plugins: [fakeInterface],
      initApi: (exec) async {},
      enabled: false,
      app: const Placeholder(),
      error: null,
    );
    expect(fakeInterface.isInitialized, true);
  });
}
