part of '../manager.dart';

final class ManagerPage extends UiPage {
  const ManagerPage({super.key});

  static const RouteName route = '/manager';

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final NavController _navController = NavController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navController.register(
      context: context,
      defaultIndex: 0,
      builders: [
        (context) {
          return HomeScreen(
            title: '主页',
            index: 0,
            label: '主页',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          );
        },
        (context) {
          return LogcatScreen(
            title: '日志',
            index: 1,
            label: '日志',
            icon: Icons.bug_report_outlined,
            selectedIcon: Icons.bug_report,
          );
        },
        (context) {
          return ModuleScreen(
            title: '模块',
            index: 2,
            label: '模块',
            icon: Icons.layers_outlined,
            selectedIcon: Icons.layers,
          );
        },
        (context) {
          return SettingScreen(
            title: '设置',
            index: 3,
            label: '设置',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
          );
        },
      ],
    );
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('管理器')),
      bottomNavigationBar: NavBar(navController: _navController),
      body: NavHost(navController: _navController),
    );
  }
}
