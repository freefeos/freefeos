part of '../loader.dart';

final class OSEntry extends FreeFEOSSystem with BaseEntry {
  OSEntry();

  @override
  TransitionBuilder get builder {
    try {
      return interface.builder;
    } catch (_) {
      return super.builder;
    }
  }
}
