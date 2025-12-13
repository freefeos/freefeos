part of '../manager.dart';

final class ActinoItem extends UiStatelessComponent {
  const ActinoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Column(
        mainAxisSize: .min,
        children: [
          Container(
            margin: .all(4),
            decoration: BoxDecoration(
              borderRadius: .all(.circular(12)),
              border: .all(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: .all(.circular(12)),
              child: Padding(padding: .all(12), child: Icon(icon)),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
