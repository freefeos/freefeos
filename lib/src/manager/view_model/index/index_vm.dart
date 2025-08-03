part of '../../manager.dart';

final class IndexViewModule with ViewModel {
  DateTime? _lastBackPressTime;

  Widget getUserApp(OSAbility ability) {
    return WidgetUtil.nonNullWidget(child: ability.getChild);
  }

  void doubleExit({
    required void Function(VoidCallback exit) showTips,
    required VoidCallback exit,
  }) {
    final DateTime now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      showTips(exit);
    } else {
      exit();
    }
  }
}
