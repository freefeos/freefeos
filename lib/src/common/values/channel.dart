part of '../common.dart';

final class VChannel {
  const VChannel();
  // runtime
  String get runtimeChannel => 'system_runtime';
  String get embedderChannel => 'platform_embedder';

  // engine
  String get bridgeChannel => 'engine_bridge';
  String get engineChannel => 'system_engine';
  String get connectChannel => 'engine_connectors';

  // kernel
}
