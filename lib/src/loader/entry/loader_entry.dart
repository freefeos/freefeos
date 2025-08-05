part of '../loader.dart';

final class OSEntry extends FreeFEOSSystem with SystemEntry {
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
