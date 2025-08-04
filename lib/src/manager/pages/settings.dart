part of '../manager.dart';

final class SettingsPage extends UiPage {
  const SettingsPage({super.key});

  static const RouteName route = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

final class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('设置')));
  }
}
