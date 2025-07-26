part of '../../manager.dart';

final class CalculatorScreen extends UiScreen {
  const CalculatorScreen({
    super.key,
    required super.title,
    required super.index,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 加载历史记录
    Provider.of<CalculatorViewModel>(context, listen: false).loadHistory();
  }

  @override
  void dispose() {
    // 销毁滚动控制器
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ScreenAdapter(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Consumer<CalculatorViewModel>(
                builder: (context, cvm, _) {
                  return Header(
                    style: HeaderStyle.calculator,
                    showBack:
                        AppUtils.getNavValue(
                          context,
                          AppsPage.exhibitArgumgent,
                        ) ==
                        true,
                    showCalculator: cvm.isShowCalculator,
                    displayText: cvm.getDisplayText,
                    outputText: cvm.getOutput,
                  );
                },
              ),
              Card.filled(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 16,
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Consumer<CalculatorViewModel>(
                  builder: (context, cvm, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                              content: CalculatorButtonContent.clear,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.backspace,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.percent,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.divide,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                              content: CalculatorButtonContent.seven,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.eight,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.nine,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.multiply,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                              content: CalculatorButtonContent.four,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.five,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.six,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.subtract,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                              content: CalculatorButtonContent.one,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.two,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.three,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.add,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                              content: CalculatorButtonContent.history,
                              onExec: (_) {
                                showBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  enableDrag: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  builder: (context) {
                                    return ScreenAdapter(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '历史记录',
                                                    style:
                                                        Theme.of(
                                                          context,
                                                        ).textTheme.titleMedium,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text('清除历史记录'),
                                                          content: Text(
                                                            '是否清除计算器历史记录?',
                                                          ),
                                                          actions: [
                                                            Tooltip(
                                                              message: '取消',
                                                              child: TextButton(
                                                                onPressed:
                                                                    () =>
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop(),
                                                                child: Text(
                                                                  '取消',
                                                                ),
                                                              ),
                                                            ),
                                                            Tooltip(
                                                              message: '确定',
                                                              child: Consumer<
                                                                CalculatorViewModel
                                                              >(
                                                                builder: (
                                                                  context,
                                                                  cvm,
                                                                  _,
                                                                ) {
                                                                  return TextButton(
                                                                    onPressed: () {
                                                                      cvm.clearHistory(); // 清除历史记录
                                                                      for (
                                                                        int i =
                                                                            0;
                                                                        i < 2;
                                                                        i++
                                                                      ) {
                                                                        // 执行两次,一次关对话框,一次关底部弹出菜单
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop();
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      '确定',
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(Icons.delete),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.close),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(height: 1),
                                          Expanded(
                                            child: Consumer<
                                              CalculatorViewModel
                                            >(
                                              builder: (context, cvm, _) {
                                                return ListView.builder(
                                                  itemCount:
                                                      cvm.getHistory.length,
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    return ListTile(
                                                      onLongPress: () {},
                                                      title: Text(
                                                        cvm.getHistory.reversed
                                                            .toList()[index],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.zero,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.number,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.point,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                            CalculatorButton(
                              content: CalculatorButtonContent.equal,
                              onExec: (content) {
                                setState(() => cvm.computing(content));
                              },
                              style: CalculatorButtonStyle.normal,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 16,
                ),
                child: Footer(style: FooterStyle.calculator),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
