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
            onFirstTap: () {
              showModalBottomSheet(
                context: context,
                // showDragHandle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.0),
                  ),
                ),
                builder: (context) {
                  return SystemSheet();
                },
              );
            },
            onLastTap: () {
              index.doubleExit(
                showTips: (exit) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('再按一次退出应用'),
                      action: SnackBarAction(label: '退出', onPressed: exit),
                    ),
                  );
                },
                exit: () {
                  SystemNavigator.pop();
                },
              );
            },
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
