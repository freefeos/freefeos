import '../base/base.dart';

import '../common/plugin/plugin_runtime.dart';
import 'platform_embedder.dart';

base mixin EmbedderMixin implements ISystemBase {
  @override
  RuntimePlugin get embedder => PlatformEmbedder();
}
