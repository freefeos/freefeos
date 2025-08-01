part of '../../manager.dart';

final class IndexViewModule with ViewModel {
  DateTime? _lastBackPressTime;

  bool defaultOffstage(OSAbility ability) {
    return ability.getChild != null;
  }

  void back({
    required void Function(VoidCallback exit) showTips,
    required VoidCallback exit,
  }) {
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      showTips(exit);
    } else {
      exit();
    }
  }
}
