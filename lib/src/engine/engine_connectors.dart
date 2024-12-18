import '../embedder/embedder_connection.dart';
import '../embedder/platform_embedder.dart';
import '../framework/want.dart';
import '../common/values/channel.dart';
import '../common/values/method.dart';
import '../common/values/strings.dart';
import 'binding.dart';
import 'method_call.dart';
import 'plugin_engine.dart';
import 'result.dart';

final class EngineConnectors extends EnginePlugin {
  @override
  String get author => developerName;

  @override
  String get channel => connectChannel;

  @override
  String get description => connectDescription;

  @override
  String get title => connectTitle;

  /// 服务实例
  late PlatformEmbedder _embedder;

  @override
  Future<void> onPluginAdded(PluginBinding binding) async {
    return await super.onPluginAdded(binding).then((added) {
      final Want want = Want(classes: PlatformEmbedder());
      final EmbedderConnection connect = EmbedderConnection(
        calback: (embedder) => _embedder = embedder,
      );
      startService(want);
      bindService(want, connect);
      return added;
    });
  }

  @override
  Future<void> onPluginMethodCall(
    EngineMethodCall call,
    EngineResult result,
  ) async {
    switch (call.method) {
      case connectGetPlugin:
        result.success(
          _embedder.getPlatformPluginList(),
        );
      case connectOpenDialog:
        result.success(
          _embedder.openPlatformDialog(),
        );
      case connectCloseDialog:
        result.success(
          _embedder.closePlatformDialog(),
        );
      default:
        result.notImplemented();
    }
  }
}
