import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freefeos/src/interface/system_interface.dart';
import 'package:freefeos/src/plugin/plugin_runtime.dart';
import 'package:freefeos/src/type/types.dart';
import 'package:freefeos/src/values/strings.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class MockFreeFEOSInterface
    with MockPlatformInterfaceMixin
    implements FreeFEOSInterface, RuntimePlugin {
  bool isInitialized = false;

  @override
  FreeFEOSInterface get interface => this;

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
  final FreeFEOSInterface initialInterface = FreeFEOSInterface.instance;

  test('$FreeFEOSInterface 是默认实例.', () {
    expect(initialInterface, isInstanceOf<FreeFEOSInterface>());
  });

  test('runFreeFEOSApp 接口调用正常.', () async {
    MockFreeFEOSInterface fakeInterface = MockFreeFEOSInterface();
    FreeFEOSInterface.instance = fakeInterface;
    await FreeFEOSInterface.instance.runFreeFEOSApp(
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
