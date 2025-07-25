part of 'embedder.dart';

final class EmbedderConnection implements ServiceConnection {
  EmbedderConnection({required this.calback});

  final void Function(PlatformEmbedder embedder) calback;

  @override
  void onServiceConnected(String name, IBinder service) {
    EmbedderBinder binder = service as EmbedderBinder;
    calback(binder.getService as PlatformEmbedder);
  }

  @override
  void onServiceDisconnected(String name) {}
}
