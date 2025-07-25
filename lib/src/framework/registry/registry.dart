part of '../framework.dart';

class Registry {
  static final Map<String, List<Widget>> _registry = {};
  static void register(String key, Widget widget) {
    if (_registry.containsKey(key)) {
      _registry[key]!.add(widget);
    } else {
      _registry[key] = [widget];
    }
  }

  static void unregister(String key, Widget widget) {}
}
