part of '../manager.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  // 路由地址
  static const RouteName route = '/app';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  _IndexPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<IndexViewModule, OSAbility>(
        builder: (context, index, ability, child) {
          return CapsuleButton(
            firstIcon: Icons.more_horiz,
            lastIcon: Icons.adjust,
            firstTooltip: '系统菜单',
            lastTooltip: '退出应用',
            onFirstTap: () => showDialog(
              context: context,
              useRootNavigator: false,
              builder: (context) {
                return AlertDialog(
                  titlePadding: EdgeInsets.zero,
                  title: ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 24.0,
                      top: 12.0,
                      right: 24.0,
                    ),
                    leading: const FlutterLogo(),
                    title: Text('appname'),
                    subtitle: Text('appversion'),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Navigator.of(context)
                      ..pop()
                      ..pushNamed(AboutPage.route),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        onPressed: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(ManagerPage.route),
                        child: Text('管理器'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(SettingsPage.route),
                        child: Text('设置'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("确定"),
                    ),
                  ],
                );
              },
            ),
            onLastTap: () => index.doubleExit(
              showTips: (exit) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('再按一次退出应用'),
                  action: SnackBarAction(label: '退出', onPressed: exit),
                ),
              ),
              exit: () => SystemNavigator.pop(),
            ),
            child: Theme(
              data: RootTheme.of(context),
              child: index.getUserApp(ability),
            ),
          );
        },
      ),
    );
  }
}
