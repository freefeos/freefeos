part of '../manager.dart';

class RootTheme extends InheritedWidget {
  const RootTheme({super.key, required this.themeData, required super.child});

  final ThemeData themeData;

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RootTheme>()?.themeData ??
        Theme.of(context);
  }

  @override
  bool updateShouldNotify(covariant RootTheme oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
