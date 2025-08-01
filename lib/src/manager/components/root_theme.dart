part of '../manager.dart';

class RootTheme extends InheritedWidget {
  const RootTheme({super.key, required this.data, required super.child});

  final ThemeData data;

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RootTheme>()?.data ??
        Theme.of(context);
  }

  @override
  bool updateShouldNotify(covariant RootTheme oldWidget) {
    return data != oldWidget.data;
  }
}
