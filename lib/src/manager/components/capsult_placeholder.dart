part of '../manager.dart';

final class CapsulePlaceholder extends UiComponent {
  const CapsulePlaceholder({super.key});

  @override
  State<CapsulePlaceholder> createState() => _CapsulePlaceholderState();
}

class _CapsulePlaceholderState extends State<CapsulePlaceholder> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: SizedBox(width: 87.0, height: 32.0),
    );
  }
}
