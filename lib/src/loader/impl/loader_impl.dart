part of '../loader.dart';

// Bootloader
final class OSLoader extends FreeFEOSLoader {
  OSLoader();

  @override
  void registerWith() {
    FreeFEOSCompat.instance = FlutterCompat();
    FreeFEOSSystem.instance = OSEntry();
  }

  @override
  TransitionBuilder get builder {
    return FreeFEOSSystem.instance.builder;
  }
}
