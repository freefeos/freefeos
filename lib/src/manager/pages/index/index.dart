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

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 计数器
  final ValueNotifier<int> _counter = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _counter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<IndexViewModule, OSAbility>(
      builder: (context, index, ability, child) {
        return Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints.expand(),
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
                leading: IconButton(
                  onPressed: () {},
                  icon: const FlutterLogo(),
                ),
                backgroundColor: index.defaultOffstage(ability)
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.primaryContainer,
                title: Offstage(
                  offstage: index.defaultOffstage(ability),
                  child: Text('默认页'),
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
                child: Scrollbar(
                  controller: _scrollController,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false, // 禁用默认滚动条
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '此页面为freefeos的默认页面, 如果您在开发过程中看到了此页面,说明您没有正确配置App, MaterialApp, CupertinoApp, WidgetsApp的home或route为空',
                            ),
                            const Text('您已经按下按钮多次了:'),
                            ValueListenableBuilder(
                              valueListenable: _counter,
                              builder: (_, value, _) => Text(
                                value.toString(),
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: Offstage(
                offstage: index.defaultOffstage(ability),
                child: FloatingActionButton(
                  tooltip: '增加',
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
