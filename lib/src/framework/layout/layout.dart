part of '../framework.dart';

final class Layout extends UiBasicComponent {
  const Layout({super.key, required this.layout});

  /// Widget
  final Widget layout;

  @override
  UiBasicElement createElement() {
    return LayoutElement(this, layout);
  }
}
