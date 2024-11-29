import 'package:flutter_test/flutter_test.dart';
import 'package:freefeos/src/embedder/platform_embedder.dart';
import 'package:freefeos/src/interface/interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFreeFEOSPlatform
    with MockPlatformInterfaceMixin
    implements FreeFEOSPlatform {
  @override
  Future<List?> getPlatformPluginList() async => List.empty();
  @override
  Future<bool?> openPlatformDialog() async => true;
  @override
  Future<bool?> closePlatformDialog() async => true;
}

void main() {
  final FreeFEOSPlatform initialPlatform = FreeFEOSPlatform.instance;

  test('$FreeFEOSPlatform 是默认实例.', () {
    expect(initialPlatform, isInstanceOf<FreeFEOSPlatform>());
  });

  test('getPlatformPluginList', () async {
    FreeFEOSPlatform.instance = MockFreeFEOSPlatform();
    FreeFEOSLinker linker = FreeFEOSLinker();
    expect(await linker.getPlatformPluginList(), List.empty());
  });

  test('openPlatformDialog', () async {
    FreeFEOSPlatform.instance = MockFreeFEOSPlatform();
    FreeFEOSLinker linker = FreeFEOSLinker();
    expect(await linker.openPlatformDialog(), true);
  });

  test('closePlatformDialog', () async {
    FreeFEOSPlatform.instance = MockFreeFEOSPlatform();
    FreeFEOSLinker linker = FreeFEOSLinker();
    expect(await linker.closePlatformDialog(), true);
  });
}
