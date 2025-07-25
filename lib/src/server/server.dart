// TODO: 服务
base class ShizukuApps {}

final class ServerBridge {
  Future<void> onCreateServer() async {}
}

base mixin class ServerBridgeMixin {
  late ServerBridge _serverBridge;

  Future<void> initServerBridge() async => _serverBridge = ServerBridge();

  ServerBridge get serverBridgeScope => _serverBridge;
}
