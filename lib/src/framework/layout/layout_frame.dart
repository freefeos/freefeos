part of '../framework.dart';

final class LayoutFrame extends ContextStatelessWrapper {
  const LayoutFrame({super.key, required this.layout});

  final Layout layout;

  @override
  Widget build(BuildContext context) {
    return Container(child: layout);
  }
}
