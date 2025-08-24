part of '../../manager.dart';

abstract interface class IIndexViewModule {
  Widget getUserApp(OSAbility ability);
  void doubleExit({required ExitCallback showTips, required VoidCallback exit});
}

final class IndexViewModule with ViewModel implements IIndexViewModule {
  DateTime? _lastBackPressTime;

  @override
  Widget getUserApp(OSAbility ability) {
    return ability.getUserApp;
  }

  @override
  void doubleExit({
    required ExitCallback showTips,
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
