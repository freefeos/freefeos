part of '../manager.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  /// 路由地址
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
            leadingIcon: Icons.more_horiz,
            leadingTooltip: '菜单',
            onLeadingTap: () => showDialog(
              context: context,
              useRootNavigator: false,
              builder: (context) {
                return AlertDialog(
                  titlePadding: .zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: .all(.circular(28)),
                  ),
                  title: Tooltip(
                    message: '关于应用',
                    child: FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) => ListTile(
                        contentPadding: const .only(
                          left: 24.0,
                          top: 12.0,
                          right: 24.0,
                        ),
                        leading: const FlutterLogo(),
                        title: Text(
                          snapshot.data?.appName ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          snapshot.data?.version ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: .only(
                            topLeft: .circular(28),
                            topRight: .circular(28),
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(AboutPage.route),
                      ),
                    ),
                  ),
                  content: Row(
                    mainAxisSize: .max,
                    mainAxisAlignment: .center,
                    children: [
                      ActinoItem(
                        icon: Icons.manage_accounts,
                        label: '管理器',
                        onTap: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(ManagerPage.route),
                      ),
                      ActinoItem(
                        icon: Icons.settings,
                        label: '设置',
                        onTap: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(SettingsPage.route),
                      ),
                    ],
                  ),
                  actions: [
                    Tooltip(
                      message: '取消',
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("取消"),
                      ),
                    ),
                  ],
                );
              },
            ),
            trailingIcon: Icons.adjust,
            trailingTooltip: '退出',
            onTrailingTap: () => index.doubleExit(
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
