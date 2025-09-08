part of '../common.dart';

final class VChannel {
  const VChannel();
  ChannelName get runtimeChannel => 'system_runtime';
  ChannelName get bridgeChannel => 'system_bridge';
  ChannelName get engineChannel => 'system_engine';
  ChannelName get kernelChannel => 'system_kernel';
  ChannelName get embedderChannel => 'system_embedder';
  ChannelName get standardChannel => 'system_sdk';
}
