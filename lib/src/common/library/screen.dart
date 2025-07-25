part of '../common.dart';

abstract base class UiScreen extends UiPage {
  const UiScreen({
    super.key,
    required this.title,
    required this.index,
    this.label,
    this.icon,
    this.selectedIcon,
  });

  final String title;
  final int index;
  final String? label;
  final IconData? icon;
  final IconData? selectedIcon;

  String get getTitle => title;
  int get getIndex => index;
  String? get getLabel => label;
  IconData? get getIcon => icon;
  IconData? get getSelectedIcon => selectedIcon;
}
