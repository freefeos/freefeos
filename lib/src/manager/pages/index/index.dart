part of '../../manager.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  // 路由地址
  static const RouteName route = '/app';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  _IndexPageState();

  /// 计数器
  final ValueNotifier<int> _counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Consumer2<IndexViewModule, OSAbility>(
      builder: (context, index, ability, child) {
        return Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Theme(
                data: RootTheme.of(context),
                child: Container(child: ability.getChild),
              ),
            ),
            Scaffold(
              backgroundColor: index.defaultOffstage(ability)
                  ? Colors.transparent
                  : null,
              appBar: AppBar(
                backgroundColor: index.defaultOffstage(ability)
                    ? Colors.transparent
                    : null,
                title: Offstage(
                  offstage: index.defaultOffstage(ability),
                  child: Text('untitled'),
                ),
                actions: [
                  Builder(
                    builder: (context) => CapsuleButton(
                      firstIcon: Icons.more_horiz,
                      lastIcon: Icons.adjust,
                      firstTooltip: '系统菜单',
                      lastTooltip: '退出应用',
                      onFirstTap: () => showModalBottomSheet(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) {
                          return SystemSheet();
                        },
                      ),
                      onLastTap: () => index.back(
                        showTips: (exit) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('再按一次退出应用'),
                              action: SnackBarAction(
                                label: '退出',
                                onPressed: exit,
                              ),
                            ),
                          );
                        },
                        exit: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: Offstage(
                offstage: index.defaultOffstage(ability),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You have pushed the button this many times:'),
                      ValueListenableBuilder(
                        valueListenable: _counter,
                        builder: (_, value, _) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(fontSize: 32),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Offstage(
                offstage: index.defaultOffstage(ability),
                child: FloatingActionButton(
                  onPressed: () => _counter.value++,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
