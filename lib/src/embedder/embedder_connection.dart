part of 'embedder.dart';

final class EmbedderConnection implements ServiceConnection {
  EmbedderConnection({required this.callback});

  final void Function(PlatformEmbedder embedder) callback;

  @override
  void onServiceConnected(String name, IBinder service) {
    EmbedderBinder binder = service as EmbedderBinder;
    callback(binder.getService as PlatformEmbedder);
  }

  @override
  void onServiceDisconnected(String name) {}
}
