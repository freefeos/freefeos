part of '../framework.dart';

final class LayoutElement extends ComponentElement {
  LayoutElement(super.widget, this.layout);

  /// Widget
  final Widget layout;

  @override
  Widget build() => layout;

  @override
  void update(Layout newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}
