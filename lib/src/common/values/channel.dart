part of '../common.dart';

final class VChannel {
  const VChannel();
  // runtime
  ChannelName get runtimeChannel => 'system_runtime';
  ChannelName get embedderChannel => 'platform_embedder';

  // engine
  ChannelName get bridgeChannel => 'engine_bridge';
  ChannelName get engineChannel => 'system_engine';
  ChannelName get connectChannel => 'engine_connectors';

  // kernel
}
