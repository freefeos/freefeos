part of '../framework.dart';

final class Layout extends Widget {
  const Layout({super.key, required this.layout});

  /// Widget
  final Widget layout;

  @override
  Element createElement() {
    return LayoutElement(this, layout);
  }
}
