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
        return CapsuleButton(
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
            showTips: (exit) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('再按一次退出应用'),
                action: SnackBarAction(label: '退出', onPressed: exit),
              ),
            ),
            exit: () => SystemNavigator.pop(),
          ),
          child: Container(child: ability.getChild ?? child),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('untitled'),
          actions: const [CapsulePlaceholder()],
        ),
        body: Center(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => _counter.value++,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
